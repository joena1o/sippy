import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

/// Service class for Firestore operations.
class FirestoreService {
  FirebaseFirestore get firestore => _firestore;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Adds a document to a collection.
  /// Takes the collection path, document data, and document ID as parameters.
  /// Throws an exception if adding the document fails.
  Future<void> addDocument({
    required String collectionPath,
    required Map<String, dynamic> data,
    String? documentId,
  }) async {
    String id = documentId ?? "";
    while (documentId == null) {
      final uniqueId = await generateUniqueIdSeperatedByHyphens();
      final existing = await firestore
          .collection(collectionPath)
          .where('id', isEqualTo: uniqueId)
          .limit(1)
          .get();

      if (existing.docs.isEmpty) {
        id = uniqueId;
        break;
      }
    }

    try {
      final docRef = _firestore.collection(collectionPath).doc(id);
      await docRef.set({
        ...data,
        "id": id,
      });
    } catch (e) {
      throw ("Error adding document: $e");
    }
  }

  /// Updates a document in a collection.
  /// Takes the collection path, document ID, and updated data as parameters.
  /// Throws an exception if updating the document fails.
  Future<void> updateDocument({
    required String collectionPath,
    required String documentId,
    required Map<String, dynamic> data,
  }) async {
    try {
      await _firestore.collection(collectionPath).doc(documentId).update(data);
    } catch (e) {
      throw ("Error updating document: $e");
    }
  }

  /// Deletes a document from a collection.
  /// Takes the collection path and document ID as parameters.
  /// Throws an exception if deleting the document fails.
  Future<void> deleteDocument({
    required String collectionPath,
    required String documentId,
  }) async {
    try {
      await _firestore.collection(collectionPath).doc(documentId).delete();
    } catch (e) {
      throw ("Error deleting document: $e");
    }
  }

  /// Fetches a document by its ID.
  /// Takes the collection path and document ID as parameters.
  /// Returns a DocumentSnapshot if successful.
  /// Throws an exception if fetching the document fails.
  Future<DocumentSnapshot<Map<String, dynamic>>> getDocumentById({
    required String collectionPath,
    required String documentId,
  }) async {
    try {
      final document =
          await _firestore.collection(collectionPath).doc(documentId).get();
      return document;
    } catch (e) {
      throw Exception(e);
    }
  }

  /// Queries documents by a field value.
  /// Takes the collection path, field name, and field value as parameters.
  /// Returns a list of QueryDocumentSnapshots if successful.
  /// Throws an exception if querying the documents fails.
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> queryDocuments({
    required String collectionPath,
    required String field,
    required dynamic value,
  }) async {
    try {
      final querySnapshot = await _firestore
          .collection(collectionPath)
          .where(field, isEqualTo: value)
          .get();
      return querySnapshot.docs;
    } catch (e) {
      throw ("Error querying documents: $e");
    }
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      queryDocumentsArray({
    required String collectionPath,
    required String field,
    required dynamic value,
  }) async {
    try {
      final querySnapshot = await _firestore
          .collection(collectionPath)
          .where(field, arrayContains: value)
          .get();
      return querySnapshot.docs;
    } catch (e) {
      throw ("Error querying documents: $e");
    }
  }

  /// Fetches all documents in a collection.
  /// Takes the collection path as a parameter.
  /// Returns a list of QueryDocumentSnapshots if successful.
  /// Throws an exception if fetching the collection fails.
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getCollection({
    required String collectionPath,
  }) async {
    try {
      final querySnapshot = await _firestore.collection(collectionPath).get();
      return querySnapshot.docs;
    } catch (e) {
      throw ("Error fetching collection: $e");
    }
  }

  /// Listens to changes in a collection.
  /// Takes the collection path as a parameter.
  /// Returns a stream of QuerySnapshots that emits changes in the collection.
  Stream<QuerySnapshot<Map<String, dynamic>>> listenToCollection({
    required String collectionPath,
  }) {
    return _firestore.collection(collectionPath).snapshots();
  }

  /// Listens to changes in a document.
  /// Takes the collection path and document ID as parameters.
  /// Returns a stream of DocumentSnapshots that emits changes in the document.
  Stream<DocumentSnapshot<Map<String, dynamic>>> listenToDocument({
    required String collectionPath,
    required String documentId,
  }) {
    return _firestore.collection(collectionPath).doc(documentId).snapshots();
  }

  Future<String> generateUniqueIdSeperatedByHyphens() async {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
    final rand = Random.secure();
    String generateChunk(int length) =>
        List.generate(length, (_) => chars[rand.nextInt(chars.length)]).join();
    final part1 = generateChunk(4);
    final part2 = generateChunk(4);
    final part3 = generateChunk(4);

    final id = '$part1-$part2-$part3';
    return id;
  }
}
