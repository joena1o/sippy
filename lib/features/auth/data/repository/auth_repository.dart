import 'package:firebase_auth/firebase_auth.dart';
import 'package:sippy_ca/core/data/data_sources/firebase_auth_service.dart';
import 'package:sippy_ca/core/data/data_sources/firestore_service.dart';
import 'package:sippy_ca/features/auth/data/models/user_model.dart';

class AuthRepository {
  FirebaseAuthService firebaseService;
  FirestoreService firestoreService;

  AuthRepository(
      {required this.firebaseService, required this.firestoreService});
  Future<UserModel> signUpWithEmailAndPassword(
      {required String email,
      required String password,
      required String firstName,
      required String lastName}) async {
    try {
      User? user = await firebaseService.signUpWithEmailPassword(
          email: email, password: password);
      if (user != null) {
        UserModel userModel = UserModel(
            id: user.uid,
            email: email,
            firstName: firstName,
            lastName: lastName,
            picture: null);
        await firestoreService.addDocument(
            collectionPath: "User",
            data: userModel.toJson(),
            documentId: user.uid);
        return userModel;
      } else {
        throw Exception("User not found");
      }
    } catch (e) {
      throw Exception("Sign Up Error: $e");
    }
  }

  Future<UserModel> signInWithEmailAndPassword(email, password) async {
    try {
      User? user = await firebaseService.signInWithEmailPassword(
          email: email, password: password);
      if (user != null) {
        final userData = await firestoreService.getDocumentById(
            collectionPath: "User", documentId: user.uid);
        UserModel userModel = UserModel.fromJson(userData.data()!);
        return userModel;
      } else {
        throw Exception("User not found");
      }
    } catch (e) {
      throw Exception("Sign Up Error: $e");
    }
  }
}
