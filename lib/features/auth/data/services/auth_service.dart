import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final String baseUrl;
  AuthService(this.baseUrl);

  static Future<GoogleSignInAccount?> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: ['email', 'profile'],
    );
    return await googleSignIn.signIn();
  }

  static Future<GoogleSignInAccount?> googleAuth() async {
    final GoogleSignInAccount? result = await AuthService.signInWithGoogle();
    return result;
  }

  static Future<String?> getGoogleIdToken() async {
    final GoogleSignInAccount? googleUser = await signInWithGoogle();
    if (googleUser == null) {
      return null; // The user canceled the sign-in
    }
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    return googleAuth.idToken; // This is what you will send to your backend
  }
}
