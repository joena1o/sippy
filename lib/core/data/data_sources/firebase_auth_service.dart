import 'package:firebase_auth/firebase_auth.dart';

/// Service class for Firebase Authentication operations.
class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Signs up a new user with email and password.
  /// Returns a User if successful.
  /// Throws an exception if sign-up fails.
  Future<User?> signUpWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw ("Sign Up Error: ${e.message}");
    }
  }

  /// Signs in a user with email and password.
  /// Returns a User if successful.
  /// Throws an exception if sign-in fails.
  Future<User?> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw ("Sign In Error: ${e.message}");
    }
  }

  /// Signs out the currently authenticated user.
  /// Returns a Future that completes when the sign-out is successful.
  Future<void> signOut() async {
    await _auth.signOut();
  }

  /// Gets the currently authenticated user.
  /// Returns a User if a user is authenticated, otherwise null.
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  /// Listens to authentication state changes.
  /// Returns a stream of User that emits authentication state changes.
  Stream<User?> authStateChanges() {
    return _auth.authStateChanges();
  }

  Future<void> sendPasswordResetEmail(String email) {
    return _auth.sendPasswordResetEmail(
      email: email,
    );
  }

  Future<void> confirmPasswordReset(
      {required String oobCode, required String newPassword}) async {
    return await _auth.confirmPasswordReset(
        code: oobCode, newPassword: newPassword);
  }
}
