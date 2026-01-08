import 'dart:io';
import '../../../core/utils/supabase_client.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart';

final supabase = SupabaseClientHelper().supabase;

class SupabaseStorageService {
  static const String bucketName = 'avatars';

  Future<String> uploadAvatar({
    required String userId,
    File? imageFile,
    Uint8List? webBytes,
  }) async {
    final filePath = '$userId/avatar.png';

    if (kIsWeb && webBytes != null) {
      await supabase.storage.from(bucketName).uploadBinary(
            filePath,
            webBytes,
            fileOptions: const FileOptions(upsert: true),
          );
    } else if (imageFile != null) {
      final bytes = await imageFile.readAsBytes();
      await supabase.storage.from(bucketName).uploadBinary(
            filePath,
            bytes,
            fileOptions: const FileOptions(upsert: true),
          );
    } else {
      throw Exception('No image provided');
    }

    return supabase.storage.from(bucketName).getPublicUrl(filePath);
  }
}
