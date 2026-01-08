import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/utils/supabase_client.dart';

class SupabaseStorageService {
  final SupabaseClient _client = SupabaseClientHelper.client;

  static const String bucketName = 'avatars';

  Future<String> uploadAvatar({
    required File imageFile,
    required String userId,
  }) async {
    final filePath = '$userId/avatar.jpg';

    await _client.storage.from(bucketName).upload(
          filePath,
          imageFile,
          fileOptions: const FileOptions(upsert: true),
        );

    return _client.storage.from(bucketName).getPublicUrl(filePath);
  }
}
