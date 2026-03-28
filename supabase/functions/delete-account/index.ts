import { serve } from "https://deno.land/std@0.177.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const SUPABASE_URL = Deno.env.get("SUPABASE_URL")!;
const SUPABASE_SERVICE_ROLE_KEY = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;

serve(async (req) => {
  try {
    // Extract JWT from Authorization header
    const authHeader = req.headers.get("Authorization");
    if (!authHeader) {
      return new Response(JSON.stringify({ error: "Missing authorization header" }), {
        status: 401,
        headers: { "Content-Type": "application/json" },
      });
    }

    // Create client with user's token to verify identity
    const userClient = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY, {
      global: { headers: { Authorization: authHeader } },
    });

    const { data: { user }, error: authError } = await userClient.auth.getUser();
    if (authError || !user) {
      return new Response(JSON.stringify({ error: "Invalid or expired token" }), {
        status: 401,
        headers: { "Content-Type": "application/json" },
      });
    }

    // Use service_role client for admin operations
    const adminClient = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY);

    // Get app user id (BIGSERIAL id, not auth UUID)
    const { data: appUser } = await adminClient
      .from("users")
      .select("id")
      .eq("auth_id", user.id)
      .single();

    if (!appUser) {
      return new Response(JSON.stringify({ error: "User not found" }), {
        status: 404,
        headers: { "Content-Type": "application/json" },
      });
    }

    const userId = appUser.id;

    // ---------------------------------------------------------------------------
    // Step 1: Soft delete in public.users
    // Nulls PII fields so the row remains for referential integrity
    // ---------------------------------------------------------------------------
    await adminClient
      .from("users")
      .update({
        is_active: false,
        deleted_at: new Date().toISOString(),
        nickname: `deleted_${userId}`,
        email: null,
        profile_image_url: null,
        introduction: null,
      })
      .eq("id", userId);

    // ---------------------------------------------------------------------------
    // Step 2: Deactivate device tokens to stop push notifications
    // ---------------------------------------------------------------------------
    try {
      await adminClient
        .from("device_tokens")
        .update({ is_active: false })
        .eq("user_id", userId);
    } catch (err) {
      console.error("Failed to deactivate device_tokens:", err);
    }

    // ---------------------------------------------------------------------------
    // Step 3: Anonymize posts — set user_id to NULL so posts remain but
    // are no longer attributed to the deleted account
    // ---------------------------------------------------------------------------
    try {
      await adminClient
        .from("posts")
        .update({ user_id: null })
        .eq("user_id", userId);
    } catch (err) {
      console.error("Failed to anonymize posts:", err);
    }

    // ---------------------------------------------------------------------------
    // Step 4: Anonymize comments — same as posts, keeps discussion intact
    // ---------------------------------------------------------------------------
    try {
      await adminClient
        .from("comments")
        .update({ user_id: null })
        .eq("user_id", userId);
    } catch (err) {
      console.error("Failed to anonymize comments:", err);
    }

    // ---------------------------------------------------------------------------
    // Step 5: Remove from all chat rooms by setting left_at = now()
    // Only affects rooms the user hasn't already left
    // ---------------------------------------------------------------------------
    try {
      await adminClient
        .from("chat_room_members")
        .update({ left_at: new Date().toISOString() })
        .eq("user_id", userId)
        .is("left_at", null);
    } catch (err) {
      console.error("Failed to remove from chat_room_members:", err);
    }

    // ---------------------------------------------------------------------------
    // Step 6: Delete friend relationships (accepted friendships)
    // The friends table uses sender_id / receiver_id columns
    // ---------------------------------------------------------------------------
    try {
      await adminClient
        .from("friends")
        .delete()
        .or(`sender_id.eq.${userId},receiver_id.eq.${userId}`);
    } catch (err) {
      console.error("Failed to delete friends:", err);
    }

    // ---------------------------------------------------------------------------
    // Step 7: Delete reports made by this user
    // Uses reporter_id column in the reports table
    // ---------------------------------------------------------------------------
    try {
      await adminClient
        .from("reports")
        .delete()
        .eq("reporter_id", userId);
    } catch (err) {
      console.error("Failed to delete reports:", err);
    }

    // ---------------------------------------------------------------------------
    // Step 8: Delete policy agreements
    // ---------------------------------------------------------------------------
    try {
      await adminClient
        .from("user_policy_agreements")
        .delete()
        .eq("user_id", userId);
    } catch (err) {
      console.error("Failed to delete user_policy_agreements:", err);
    }

    // ---------------------------------------------------------------------------
    // Step 9: Delete blocked_users entries
    // The table is user_blocks, with blocker_id and blocked_id columns
    // ---------------------------------------------------------------------------
    try {
      await adminClient
        .from("user_blocks")
        .delete()
        .or(`blocker_id.eq.${userId},blocked_id.eq.${userId}`);
    } catch (err) {
      console.error("Failed to delete user_blocks:", err);
    }

    // ---------------------------------------------------------------------------
    // Step 10: Hard delete from auth.users (requires service_role)
    // Must be last — once this runs the auth identity is gone
    // ---------------------------------------------------------------------------
    const { error: deleteError } = await adminClient.auth.admin.deleteUser(user.id);
    if (deleteError) {
      console.error("Failed to delete auth user:", deleteError);
      return new Response(
        JSON.stringify({ error: "Failed to delete authentication account" }),
        { status: 500, headers: { "Content-Type": "application/json" } },
      );
    }

    return new Response(JSON.stringify({ success: true }), {
      status: 200,
      headers: { "Content-Type": "application/json" },
    });
  } catch (error) {
    console.error("delete-account error:", error);
    return new Response(JSON.stringify({ error: (error as Error).message }), {
      status: 500,
      headers: { "Content-Type": "application/json" },
    });
  }
});
