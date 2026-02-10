import { serve } from "https://deno.land/std@0.177.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";
import {
  decode as base64Decode,
  encode as base64Encode,
} from "https://deno.land/std@0.177.0/encoding/base64url.ts";

// ─── Environment ───────────────────────────────────────────────
const SUPABASE_URL = Deno.env.get("SUPABASE_URL")!;
const SUPABASE_SERVICE_ROLE_KEY = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;
// Firebase service account JSON stored as a secret
const FCM_SERVICE_ACCOUNT_JSON = Deno.env.get("FCM_SERVICE_ACCOUNT_JSON")!;

interface ServiceAccount {
  project_id: string;
  private_key: string;
  client_email: string;
}

interface NotificationPayload {
  type: string;
  actor_id: number;
  receiver_id: number;
  post_id?: number;
  comment_id?: number;
  chat_room_id?: number;
  message?: string;
}

// ─── OAuth2 Token Cache ────────────────────────────────────────
let cachedAccessToken: string | null = null;
let tokenExpiresAt = 0;

serve(async (req) => {
  try {
    const payload: NotificationPayload = await req.json();
    const { type, actor_id, receiver_id, post_id, comment_id, chat_room_id, message } = payload;

    // Don't notify self
    if (actor_id === receiver_id) {
      return jsonResponse({ skipped: "self-notification" });
    }

    const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY);

    // Get actor info
    const { data: actor } = await supabase
      .from("users")
      .select("nickname")
      .eq("id", actor_id)
      .single();

    const actorNickname = actor?.nickname ?? "Someone";
    const notificationMessage = message ?? buildNotificationMessage(type, actorNickname);

    // Insert notification row
    await supabase.from("notifications").insert({
      user_id: receiver_id,
      actor_id: actor_id,
      actor_nickname: actorNickname,
      type: type,
      post_id: post_id ?? null,
      comment_id: comment_id ?? null,
      chat_room_id: chat_room_id ?? null,
      message: notificationMessage,
    });

    // Get active device tokens
    const { data: tokens } = await supabase
      .from("device_tokens")
      .select("token")
      .eq("user_id", receiver_id)
      .eq("is_active", true);

    if (!tokens || tokens.length === 0) {
      return jsonResponse({ sent: false, reason: "no_tokens" });
    }

    // Build FCM v1 data payload
    const fcmData: Record<string, string> = { type: mapNotificationType(type) };
    if (post_id) fcmData.id = post_id.toString();
    if (chat_room_id) fcmData.id = chat_room_id.toString();

    // Get OAuth2 access token for FCM v1 API
    const serviceAccount: ServiceAccount = JSON.parse(FCM_SERVICE_ACCOUNT_JSON);
    const accessToken = await getAccessToken(serviceAccount);

    // Send to each token via FCM v1 API
    const tokenList = tokens.map((t: { token: string }) => t.token);
    const result = await sendFcmV1(
      serviceAccount.project_id,
      accessToken,
      tokenList,
      buildFcmTitle(type),
      notificationMessage,
      fcmData,
    );

    // Deactivate invalid tokens
    for (const invalidToken of result.invalidTokens) {
      await supabase
        .from("device_tokens")
        .update({ is_active: false })
        .eq("token", invalidToken);
    }

    return jsonResponse({
      sent: true,
      success_count: result.successCount,
      failure_count: result.failureCount,
    });
  } catch (error) {
    console.error("send-notification error:", error);
    return jsonResponse({ error: (error as Error).message }, 500);
  }
});

// ─── FCM v1 API ────────────────────────────────────────────────

interface FcmResult {
  successCount: number;
  failureCount: number;
  invalidTokens: string[];
}

async function sendFcmV1(
  projectId: string,
  accessToken: string,
  tokens: string[],
  title: string,
  body: string,
  data: Record<string, string>,
): Promise<FcmResult> {
  const invalidTokens: string[] = [];
  let successCount = 0;
  let failureCount = 0;

  // FCM v1 sends one message per token
  const promises = tokens.map(async (token) => {
    try {
      const response = await fetch(
        `https://fcm.googleapis.com/v1/projects/${projectId}/messages:send`,
        {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
            Authorization: `Bearer ${accessToken}`,
          },
          body: JSON.stringify({
            message: {
              token: token,
              notification: { title, body },
              data: data,
              android: { priority: "high" },
              apns: {
                payload: { aps: { sound: "default", badge: 1 } },
              },
            },
          }),
        },
      );

      if (response.ok) {
        successCount++;
      } else {
        failureCount++;
        const errorBody = await response.json();
        const errorCode = errorBody?.error?.details?.[0]?.errorCode
          ?? errorBody?.error?.status;
        if (
          errorCode === "UNREGISTERED" ||
          errorCode === "INVALID_ARGUMENT"
        ) {
          invalidTokens.push(token);
        }
        console.error(`FCM send failed for token: ${errorCode}`);
      }
    } catch (e) {
      failureCount++;
      console.error(`FCM send error: ${e}`);
    }
  });

  await Promise.all(promises);
  return { successCount, failureCount, invalidTokens };
}

// ─── Google OAuth2 (JWT → Access Token) ────────────────────────

async function getAccessToken(sa: ServiceAccount): Promise<string> {
  const now = Math.floor(Date.now() / 1000);

  // Return cached token if still valid (with 60s buffer)
  if (cachedAccessToken && now < tokenExpiresAt - 60) {
    return cachedAccessToken;
  }

  const header = { alg: "RS256", typ: "JWT" };
  const claimSet = {
    iss: sa.client_email,
    scope: "https://www.googleapis.com/auth/firebase.messaging",
    aud: "https://oauth2.googleapis.com/token",
    iat: now,
    exp: now + 3600,
  };

  const encodedHeader = base64Encode(new TextEncoder().encode(JSON.stringify(header)));
  const encodedClaims = base64Encode(new TextEncoder().encode(JSON.stringify(claimSet)));
  const signInput = `${encodedHeader}.${encodedClaims}`;

  // Import RSA private key and sign
  const signature = await signWithRSA(sa.private_key, signInput);
  const jwt = `${signInput}.${signature}`;

  // Exchange JWT for access token
  const tokenResponse = await fetch("https://oauth2.googleapis.com/token", {
    method: "POST",
    headers: { "Content-Type": "application/x-www-form-urlencoded" },
    body: `grant_type=urn:ietf:params:oauth:grant-type:jwt-bearer&assertion=${jwt}`,
  });

  if (!tokenResponse.ok) {
    const err = await tokenResponse.text();
    throw new Error(`OAuth2 token exchange failed: ${err}`);
  }

  const tokenData = await tokenResponse.json();
  cachedAccessToken = tokenData.access_token;
  tokenExpiresAt = now + (tokenData.expires_in ?? 3600);
  return cachedAccessToken!;
}

async function signWithRSA(privateKeyPem: string, data: string): Promise<string> {
  // Parse PEM to DER
  const pemContents = privateKeyPem
    .replace(/-----BEGIN PRIVATE KEY-----/g, "")
    .replace(/-----END PRIVATE KEY-----/g, "")
    .replace(/\s/g, "");

  const binaryDer = Uint8Array.from(atob(pemContents), (c) => c.charCodeAt(0));

  const cryptoKey = await crypto.subtle.importKey(
    "pkcs8",
    binaryDer,
    { name: "RSASSA-PKCS1-v1_5", hash: "SHA-256" },
    false,
    ["sign"],
  );

  const signatureBuffer = await crypto.subtle.sign(
    "RSASSA-PKCS1-v1_5",
    cryptoKey,
    new TextEncoder().encode(data),
  );

  return base64Encode(new Uint8Array(signatureBuffer));
}

// ─── Helpers ───────────────────────────────────────────────────

function jsonResponse(body: Record<string, unknown>, status = 200): Response {
  return new Response(JSON.stringify(body), {
    status,
    headers: { "Content-Type": "application/json" },
  });
}

function buildNotificationMessage(type: string, actorNickname: string): string {
  switch (type) {
    case "POST_LIKE":
      return `${actorNickname} liked your post`;
    case "COMMENT_LIKE":
      return `${actorNickname} liked your comment`;
    case "NEW_COMMENT":
      return `${actorNickname} commented on your post`;
    case "NEW_REPLY":
      return `${actorNickname} replied to your comment`;
    case "FRIEND_REQUEST":
      return `${actorNickname} sent you a friend request`;
    case "FRIEND_ACCEPT":
      return `${actorNickname} accepted your friend request`;
    case "CHAT_MESSAGE":
      return `${actorNickname} sent you a message`;
    default:
      return "You have a new notification";
  }
}

function buildFcmTitle(type: string): string {
  switch (type) {
    case "POST_LIKE":
    case "COMMENT_LIKE":
      return "New Like";
    case "NEW_COMMENT":
    case "NEW_REPLY":
      return "New Comment";
    case "FRIEND_REQUEST":
    case "FRIEND_ACCEPT":
      return "Friends";
    case "CHAT_MESSAGE":
      return "New Message";
    default:
      return "Nonstop";
  }
}

function mapNotificationType(type: string): string {
  switch (type) {
    case "CHAT_MESSAGE":
      return "chat";
    case "POST_LIKE":
    case "COMMENT_LIKE":
    case "NEW_COMMENT":
    case "NEW_REPLY":
      return "post";
    case "FRIEND_REQUEST":
    case "FRIEND_ACCEPT":
      return "friend";
    default:
      return "notification";
  }
}
