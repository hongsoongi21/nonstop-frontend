import { serve } from "https://deno.land/std@0.177.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const SUPABASE_URL = Deno.env.get("SUPABASE_URL")!;
const SUPABASE_SERVICE_ROLE_KEY = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;
const RESEND_API_KEY = Deno.env.get("RESEND_API_KEY")!;

serve(async (req) => {
  try {
    const { email } = await req.json();

    if (!email) {
      return jsonResponse({ error: "Email is required" }, 400);
    }

    const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY);

    // Generate 6-digit code
    const code = Math.floor(100000 + Math.random() * 900000).toString();

    // Invalidate previous codes for this email
    await supabase
      .from("email_verifications")
      .update({ used: true })
      .eq("email", email)
      .eq("used", false);

    // Store new code
    await supabase.from("email_verifications").insert({
      email,
      code,
      expires_at: new Date(Date.now() + 5 * 60 * 1000).toISOString(),
    });

    // Send email via Resend
    const resendResponse = await fetch("https://api.resend.com/emails", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${RESEND_API_KEY}`,
      },
      body: JSON.stringify({
        from: "Nonstop <onboarding@resend.dev>",
        to: [email],
        subject: "Nonstop - Email Verification Code",
        html: `
          <div style="font-family: 'Helvetica Neue', Arial, sans-serif; max-width: 480px; margin: 0 auto; padding: 40px 24px;">
            <div style="text-align: center; margin-bottom: 32px;">
              <h1 style="color: #1E4D7B; font-size: 28px; font-weight: 800; margin: 0;">Nonstop</h1>
              <p style="color: #64748B; font-size: 14px; margin-top: 8px;">Email Verification</p>
            </div>
            <div style="background: #F8FAFC; border-radius: 16px; padding: 32px; text-align: center;">
              <p style="color: #334155; font-size: 15px; margin: 0 0 24px;">Your verification code is:</p>
              <div style="background: #1E4D7B; color: white; font-size: 32px; font-weight: 800; letter-spacing: 8px; padding: 16px 32px; border-radius: 12px; display: inline-block;">
                ${code}
              </div>
              <p style="color: #94A3B8; font-size: 13px; margin-top: 24px;">This code expires in 5 minutes.</p>
            </div>
            <p style="color: #94A3B8; font-size: 12px; text-align: center; margin-top: 32px;">
              If you didn't request this code, please ignore this email.
            </p>
          </div>
        `,
      }),
    });

    if (!resendResponse.ok) {
      const error = await resendResponse.text();
      console.error("Resend API error:", error);
      return jsonResponse({ error: "Failed to send verification email" }, 500);
    }

    return jsonResponse({ success: true, message: "Verification code sent" });
  } catch (error) {
    console.error("send-verification-email error:", error);
    return jsonResponse({ error: (error as Error).message }, 500);
  }
});

function jsonResponse(body: Record<string, unknown>, status = 200): Response {
  return new Response(JSON.stringify(body), {
    status,
    headers: { "Content-Type": "application/json" },
  });
}
