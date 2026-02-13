import { serve } from "https://deno.land/std@0.177.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const SUPABASE_URL = Deno.env.get("SUPABASE_URL")!;
const SUPABASE_SERVICE_ROLE_KEY = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;

serve(async (req) => {
  try {
    const { email, code } = await req.json();

    if (!email || !code) {
      return jsonResponse({ error: "Email and code are required" }, 400);
    }

    const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY);

    // Find matching, unexpired, unused code
    const { data: verification, error } = await supabase
      .from("email_verifications")
      .select("*")
      .eq("email", email)
      .eq("code", code)
      .eq("used", false)
      .gte("expires_at", new Date().toISOString())
      .order("created_at", { ascending: false })
      .limit(1)
      .maybeSingle();

    if (error || !verification) {
      return jsonResponse({
        verified: false,
        error: "Invalid or expired verification code"
      }, 400);
    }

    // Mark code as used
    await supabase
      .from("email_verifications")
      .update({ used: true })
      .eq("id", verification.id);

    return jsonResponse({ verified: true });
  } catch (error) {
    console.error("verify-email-code error:", error);
    return jsonResponse({ error: (error as Error).message }, 500);
  }
});

function jsonResponse(body: Record<string, unknown>, status = 200): Response {
  return new Response(JSON.stringify(body), {
    status,
    headers: { "Content-Type": "application/json" },
  });
}
