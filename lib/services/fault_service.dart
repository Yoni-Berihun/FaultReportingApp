import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import '../core/app_config.dart';
import '../models/fault_report.dart';
import '../supabase_service.dart';

class FaultService {
  static final SupabaseService _supabaseService = SupabaseService();

  /// Generates a unique tracking ID like "FLT-A3X9K2M"
  static String generateTrackingId() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final rand = Random();
    final suffix =
        List.generate(7, (_) => chars[rand.nextInt(chars.length)]).join();
    return 'FLT-$suffix';
  }

  /// Full submission flow:
  ///  1. Upload photo to Supabase Storage (if any)
  ///  2. Save report to Supabase `reports` table
  ///
  /// Returns the tracking ID on success, throws on failure.
  static Future<String> submitReport(FaultReport report) async {
    final trackingId = generateTrackingId();

    // 1. Upload photo (optional) — private bucket; path stored, no long-lived public URL
    String? photoStoragePath;
    if (report.photoPath != null) {
      try {
        photoStoragePath = await _uploadPhoto(report.photoPath!, trackingId);
      } catch (e) {
        throw Exception('Photo upload step failed: $e');
      }
    }

    // 2. Save to Supabase table
    final payload = {
      'tracking_id': trackingId,
      'common_name': report.commonName,
      'description': report.description,
      'contact_number': report.phoneNumber,
      'latitude': report.latitude,
      'longitude': report.longitude,
      'photo_storage_path': photoStoragePath,
      'photo_url': null,
      'status': 'pending',
    };

    try {
      await _supabaseService.insertData('reports', payload);
    } catch (e) {
      throw Exception('Database insert step failed: $e');
    }

    return trackingId;
  }

  /// Uploads the photo to Supabase Storage and returns the object path in the bucket.
  static Future<String> _uploadPhoto(
      String localPath, String trackingId) async {
    final file = File(localPath);
    if (!await file.exists()) {
      throw Exception('Selected photo file no longer exists on device.');
    }

    final ext = localPath.split('.').last;
    final bytes = Uint8List.fromList(await file.readAsBytes());
    final filePath = 'reports/$trackingId.$ext';

    return _supabaseService.uploadPrivateObject(
      AppConfig.instance.faultReportsBucket,
      filePath,
      bytes,
    );
  }
}
