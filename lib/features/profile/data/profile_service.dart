import 'package:firebase_auth/firebase_auth.dart';

class ProfileService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;


  /// [currentPassword] 
  Future<void> updateProfile({
    String? displayName,
    String? photoUrl,
    String? newPassword,
    String? currentPassword,
  }) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User belum login');
    }
    if (displayName != null && displayName.isNotEmpty) {
      await user.updateDisplayName(displayName);
    }


    if (photoUrl != null && photoUrl.isNotEmpty) {
      await user.updatePhotoURL(photoUrl);
    }

    if (newPassword != null && newPassword.isNotEmpty) {
      if (currentPassword == null || currentPassword.isEmpty) {
        throw Exception('Password lama wajib diisi untuk mengganti password');
      }

      final cred = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );

      try {
        await user.reauthenticateWithCredential(cred);
        await user.updatePassword(newPassword);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'wrong-password') {
          throw Exception('Password lama salah');
        } else if (e.code == 'requires-recent-login') {
          throw Exception('Silakan login ulang sebelum ganti password');
        } else {
          throw Exception('Gagal update password: ${e.message}');
        }
      }
    }

  
    await user.reload();
  }


  Future<void> logout() async {
    await _auth.signOut();
  }
}
