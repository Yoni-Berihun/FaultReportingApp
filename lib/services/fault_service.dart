import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/fault_report.dart';

class FirebaseSetupException implements Exception {
  final String message;
  const FirebaseSetupException(this.message);

  @override
  String toString() => message;
}

class FaultService {
  static FirebaseFirestore get _firestore => FirebaseFirestore.instance;
  static FirebaseStorage get _storage => FirebaseStorage.instance;
  static FirebaseFunctions get _functions => FirebaseFunctions.instance;

  // ─── Maintenance team recipient number ───────────────────────────────────
  // Change this to the phone number that should receive SMS alerts.
  // Format: international with + prefix, e.g. +251911234567 for Ethiopia.
  static const String maintenancePhoneNumber = '+251911234567';
  // ─────────────────────────────────────────────────────────────────────────

  /// Generates a unique tracking ID like "FLT-A3X9K2M"
  static String generateTrackingId() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final rand = Random();
    final suffix = List.generate(7, (_) => chars[rand.nextInt(chars.length)]).join();
    return 'FLT-$suffix';
  }

  /// Full submission flow:
  ///  1. Upload photo to Firebase Storage (if any)
  ///  2. Save report to Firestore
  ///  3. Call Cloud Function → sends SMS via Africa's Talking
  ///
  /// Returns the tracking ID on success, throws on failure.
  static Future<String> submitReport(FaultReport report) async {
    await _ensureFirebaseReady();

    final trackingId = generateTrackingId();

    // 1. Upload photo (optional)
    String? photoUrl;
    if (report.photoPath != null) {
      photoUrl = await _uploadPhoto(report.photoPath!, trackingId);
    }

    final finalReport = report.copyWith(photoUrl: photoUrl);

    // 2. Save to Firestore
    await _firestore
        .collection('fault_reports')
        .doc(trackingId)
        .set(finalReport.toFirestore(trackingId));

    // 3. Trigger SMS via Cloud Function
    await _sendSmsNotification(finalReport, trackingId);

    return trackingId;
  }

  static Future<void> _ensureFirebaseReady() async {
    if (Firebase.apps.isNotEmpty) return;

    try {
      await Firebase.initializeApp();
    } catch (_) {
      throw const FirebaseSetupException(
        'Firebase is not configured for this app. Run `flutterfire configure` in the project root, add Android app registration (google-services.json), then rebuild and retry submission.',
      );
    }
  }

  /// Uploads the photo to Firebase Storage and returns its download URL.
  static Future<String> _uploadPhoto(String localPath, String trackingId) async {
    final file = File(localPath);
    final ext = localPath.split('.').last;
    final ref = _storage.ref('fault_photos/$trackingId.$ext');

    final uploadTask = await ref.putFile(
      file,
      SettableMetadata(contentType: 'image/$ext'),
    );

    return await uploadTask.ref.getDownloadURL();
  }

  /// Calls the Firebase Cloud Function `sendFaultSms`.
  static Future<void> _sendSmsNotification(
    FaultReport report,
    String trackingId,
  ) async {
    final callable = _functions.httpsCallable('sendFaultSms');
    await callable.call({
      'trackingId': trackingId,
      'description': report.description,
      'location': report.commonName.isNotEmpty
          ? report.commonName
          : '${report.latitude.toStringAsFixed(4)}, ${report.longitude.toStringAsFixed(4)}',
      'reporterPhone': report.phoneNumber,
      'maintenancePhone': maintenancePhoneNumber,
    });
  }
}
