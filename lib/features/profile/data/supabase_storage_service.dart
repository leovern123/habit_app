import 'dart:io';
import '../../../core/utils/supabase_client.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = SupabaseClientHelper().supabase;

class SupabaseStorageService {
  static const String bucketName = 'avatars';

  Future<String> uploadAvatar({
    required File imageFile,
    required String userId,
  }) async {
    final bytes = await imageFile.readAsBytes();
    final filePath = '$userId/avatar.png';

    await supabase.storage
        .from(bucketName)
        .uploadBinary(
          filePath,
          bytes,
          fileOptions: const FileOptions(upsert: true),
        );

    return supabase.storage
        .from(bucketName)
        .getPublicUrl(filePath);
  }
}
