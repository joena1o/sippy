import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sippy_ca/core/data/data_sources/firebase_auth_service.dart';
import 'package:sippy_ca/core/data/data_sources/firestore_service.dart';
import 'package:sippy_ca/features/auth/data/models/user_model.dart';
import 'package:sippy_ca/features/homepage/data/models/shopping_invite_model.dart';

class InviteRepository {
  FirebaseAuthService firebaseAuthService;
  FirestoreService firestoreService;

  InviteRepository(
      {required this.firebaseAuthService, required this.firestoreService});

  Future<String> createShoppingInvite(
      UserModel user, String name, List<String> emails) async {
    try {
      final docRef =
          await firestoreService.firestore.collection("collab-shopping").add({
        "createdBy": user.id,
        "creators_name": user.firstName,
        "name": name,
        "inviter_email": user.email,
        "emails": emails,
        "accepted": [],
        "declined": []
      });
      return docRef.id;
    } catch (e) {
      throw Exception("Unable to create invite: $e");
    }
  }

  Future<List<ShoppingInviteModel>> fetchInvitation(String email) async {
    try {
      final collabList = await FirebaseFirestore.instance
          .collection('collab-shopping')
          .where("emails", arrayContains: email)
          .get();
      return collabList.docs
          .map((doc) => ShoppingInviteModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception("Unable to fetch invite: $e");
    }
  }

  Future<List<ShoppingInviteModel>> fetchCollabShops(String email) async {
    try {
      final emailsQuery = await FirebaseFirestore.instance
          .collection('collab-shopping')
          .where("accepted", arrayContains: email)
          .get();

      final inviterQuery = await FirebaseFirestore.instance
          .collection('collab-shopping')
          .where("inviter_email", isEqualTo: email)
          .get();

      final allDocs = [...emailsQuery.docs, ...inviterQuery.docs];

      // Remove duplicates by document ID
      final uniqueDocs = {
        for (var doc in allDocs) doc.id: doc,
      }.values.toList();
      return uniqueDocs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return ShoppingInviteModel.fromJson(data);
      }).toList();
    } catch (e) {
      throw Exception("Unable to fetch collabs invite: $e");
    }
  }

  Future<void> acceptOrDeclineInvite(
      ShoppingInviteModel invite, String email, bool accept) async {
    try {
      await firestoreService.firestore
          .collection("collab-shopping")
          .doc(invite.id)
          .update(accept
              ? {
                  "accepted": FieldValue.arrayUnion([email])
                }
              : {
                  "declined": FieldValue.arrayUnion([email])
                });
    } catch (e) {
      throw Exception("Unable to execute your task: $e");
    }
  }
}
