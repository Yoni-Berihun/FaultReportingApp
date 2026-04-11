import 'dart:typed_data';

import 'package:supabase_flutter/supabase_flutter.dart';

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

  // Upload a file to Supabase Storage
  // bucketName: name of the bucket (e.g., 'photos')
  // filePath: path inside the bucket (e.g., 'user123/image.jpg')
  // fileBytes: the bytes of the file to upload
  Future<String> uploadFile(
      String bucketName, String filePath, Uint8List fileBytes) async {
    try {
      await _client.storage.from(bucketName).uploadBinary(
            filePath,
            fileBytes,
            fileOptions: const FileOptions(upsert: false),
          );
    } on StorageException catch (e) {
      throw Exception(
        'Storage upload failed (bucket: $bucketName, path: $filePath, status: ${e.statusCode}, error: ${e.error}): ${e.message}',
      );
    }

    // Get the public URL
    final publicUrl = _client.storage.from(bucketName).getPublicUrl(filePath);
    return publicUrl;
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
