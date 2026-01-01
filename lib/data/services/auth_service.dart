import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;


class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final GoogleSignIn _googleSignIn = GoogleSignIn(
     clientId: kIsWeb
        ? '871204951466-ote0j9r5lkdfuqoicgdje9abvusmpce9.apps.googleusercontent.com'
        : null,
  );

  Future<User> loginWithEmail({
    required String email,
    required String password,
  }) async {
    final result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result.user!;
  }

  Future<User> loginWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      throw FirebaseAuthException(
        code: 'CANCELLED',
        message: 'Login dibatalkan',
      );
    }

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final result = await _auth.signInWithCredential(credential);
    return result.user!;
  }

  User? get currentUser => _auth.currentUser;

  Future<void> logout() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}
