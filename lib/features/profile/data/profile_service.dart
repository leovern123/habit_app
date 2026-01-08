import 'package:firebase_auth/firebase_auth.dart';

class ProfileService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  Future<void> updateProfile({
    String? displayName,
    String? photoUrl,
    String? newPassword,
  }) async {
    final user = currentUser;
    if (user == null) return;

    if (displayName != null) {
      await user.updateDisplayName(displayName);
    }

    if (photoUrl != null) {
      await user.updatePhotoURL(photoUrl);
    }

    if (newPassword != null && newPassword.isNotEmpty) {
      await user.updatePassword(newPassword);
    }

    await user.reload();
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
