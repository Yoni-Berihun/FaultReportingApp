import 'dart:typed_data';

import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:fault_reporting_app/core/app_config.dart';

class SupabaseService {
  // Get the Supabase client instance
  final SupabaseClient _client = Supabase.instance.client;

  // --- AUTHENTICATION ---

  // Sign up with email and password
  Future<AuthResponse> signUp(String email, String password) async {
    return await _client.auth.signUp(
      email: email,
      password: password,
    );
  }

  // Sign in with email and password
  Future<AuthResponse> signIn(String email, String password) async {
    return await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  // Sign out
  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  // Get current user
  User? get currentUser => _client.auth.currentUser;

  // --- STORAGE ---

  /// Uploads bytes to storage and returns the **object path** inside the
  /// bucket (private access; use [createSignedUrlForObject] to view).
  Future<String> uploadPrivateObject(
      String bucketName, String objectPath, Uint8List fileBytes) async {
    try {
      await _client.storage.from(bucketName).uploadBinary(
            objectPath,
            fileBytes,
            fileOptions: const FileOptions(upsert: false),
          );
    } on StorageException catch (e) {
      throw Exception(
        'Storage upload failed (bucket: $bucketName, path: $objectPath, status: ${e.statusCode}, error: ${e.error}): ${e.message}',
      );
    }
    return objectPath;
  }

  Future<String> createSignedUrlForObject(
      String bucketName, String objectPath) async {
    final seconds = AppConfig.instance.fixerStorageSignedUrlSeconds;
    return _client.storage
        .from(bucketName)
        .createSignedUrl(objectPath, seconds);
  }

  Future<List<Map<String, dynamic>>> fetchReports(
      {DateTime? sinceCreatedAt, int limit = 2000}) async {
    var query = _client.from('reports').select();
    if (sinceCreatedAt != null) {
      query = query.gte('created_at', sinceCreatedAt.toUtc().toIso8601String());
    }
    final res = await query.order('created_at', ascending: false);
    final list = List<Map<String, dynamic>>.from(res);
    if (list.length > limit) {
      return list.sublist(0, limit);
    }
    return list;
  }

  Future<Map<String, dynamic>?> getReportById(int id) async {
    final res = await _client.from('reports').select().eq('id', id) as List<dynamic>;
    final list = res;
    if (list.isEmpty) {
      return null;
    }
    return Map<String, dynamic>.from(list.first as Map);
  }

  Future<void> markReportSeen(int id) async {
    final now = DateTime.now().toUtc().toIso8601String();
    await _client.from('reports').update({
      'status': 'seen',
      'seen_at': now,
      'updated_at': now,
    }).eq('id', id);
  }

  /// Auto-resolve reports that have been in `seen` for at least [days].
  Future<void> applyServerSideAutoResolve({int days = 3}) async {
    final threshold = DateTime.now().toUtc().subtract(Duration(days: days));
    final t = threshold.toIso8601String();
    final now = DateTime.now().toUtc().toIso8601String();
    await _client
        .from('reports')
        .update({
          'status': 'resolved',
          'resolved_at': now,
          'updated_at': now,
        })
        .eq('status', 'seen')
        .lt('seen_at', t);
  }

  // --- DATABASE (Firestore equivalent) ---

  // Insert data into a table
  // tableName: name of the table (e.g., 'reports')
  // data: Map of column names to values
  Future<void> insertData(String tableName, Map<String, dynamic> data) async {
    try {
      await _client.from(tableName).insert(data);
    } on PostgrestException catch (e) {
      throw Exception(
        'Database insert failed (table: $tableName, code: ${e.code}, message: ${e.message}, details: ${e.details}, hint: ${e.hint}, payload: $data)',
      );
    }
  }

  // Get all data from a table
  Future<List<Map<String, dynamic>>> getAllData(String tableName) async {
    final response = await _client.from(tableName).select();
    return response;
  }
}
