import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:appointment_system/core/models/base_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addDocument(String collection, Map<String, dynamic> data) async {
    await _db.collection(collection).add(data);
  }

  Future<void> setDocument(String collection, String docId, Map<String, dynamic> data) async {
    await _db.collection(collection).doc(docId).set(data);
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getDocumentById(String collection, String docId) async {
    return await _db.collection(collection).doc(docId).get();
  }

  Future<T?> getDocument<T extends BaseModel>(String collection, String docId, T Function(Map<String, dynamic>) fromJson) async {
    final doc = await _db.collection(collection).doc(docId).get();
    return doc.exists ? fromJson(doc.data()!) : null;
  }

  Stream<List<T>> streamCollection<T extends BaseModel>(String collection, T Function(Map<String, dynamic>) fromJson) {
    return _db.collection(collection).snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => fromJson(doc.data()!)).toList());
  }

  Future<void> updateDocument(String collection, String docId, Map<String, dynamic> data) async {
    await _db.collection(collection).doc(docId).update(data);
  }

  Future<void> deleteDocument(String collection, String docId) async {
    await _db.collection(collection).doc(docId).delete();
  }
}