import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import AfricasTalking from "africastalking";

admin.initializeApp();

// ─── Africa's Talking credentials ────────────────────────────────────────────
// Store these as Firebase environment config — never hard-code them.
// Deploy with:
//   firebase functions:config:set at.api_key="YOUR_KEY" at.username="YOUR_USERNAME"
// ─────────────────────────────────────────────────────────────────────────────
const atUsername: string = functions.config().at?.username ?? "sandbox";
const atApiKey: string   = functions.config().at?.api_key  ?? "YOUR_API_KEY";

const AT = AfricasTalking({ username: atUsername, apiKey: atApiKey });
const sms = AT.SMS;

interface SmsPayload {
  trackingId: string;
  description: string;
  location: string;
  reporterPhone: string;
  maintenancePhone: string;  // set in fault_service.dart
}

/**
 * sendFaultSms
 * Called from Flutter via cloud_functions package.
 * Sends an SMS to the maintenance team with full fault details.
 */
export const sendFaultSms = functions.https.onCall(
  async (data: SmsPayload, context) => {
    const { trackingId, description, location, reporterPhone, maintenancePhone } = data;

    // Build the SMS body
    const message =
      `🔧 NEW FAULT REPORT\n` +
      `ID: ${trackingId}\n` +
      `Location: ${location}\n` +
      `Issue: ${description}\n` +
      `Reporter: ${reporterPhone}\n` +
      `View in console: https://console.firebase.google.com`;

    try {
      const result = await sms.send({
        to:      [maintenancePhone],
        message: message,
        // from: "HU-Faults",  // uncomment if you have an approved sender ID
      });

      functions.logger.info("SMS sent", result);

      return { success: true, messageId: result.SMSMessageData?.Recipients?.[0]?.messageId };
    } catch (error) {
      functions.logger.error("SMS failed", error);
      throw new functions.https.HttpsError("internal", "Failed to send SMS");
    }
  }
);
