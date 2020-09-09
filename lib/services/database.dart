import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/models/notesmodel.dart';
import 'package:todo_app/models/usermodel.dart';

class Database {
  final Firestore _firestore = Firestore.instance;

  Future<bool> createNewuser(UserModel user) async {
    try {
      await _firestore.collection('users').document(user.uid).setData({
        'uid': user.uid,
        'name': user.name,
        'email': user.email,
        'accountCreated': Timestamp.now(),
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<UserModel> getUser(String uid) async {
    try {
      DocumentSnapshot _doc =
          await _firestore.collection('users').document(uid).get();
      return UserModel.fromDocumentSnapshot(documentSnapshot: _doc);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addTodos(String content, String uid) async {
    try {
      await _firestore
          .collection('users')
          .document(uid)
          .collection('notes')
          .add({
        'dateCreated': Timestamp.now(),
        'content': content,
        'done': false,
      });
    } catch (e) {}
  }

  Stream<List<NotesModel>> todoStream(String uid) {
    return _firestore
        .collection('users')
        .document(uid)
        .collection('notes')
        .orderBy('dateCreated', descending: true)
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<NotesModel> retVal = List();
      querySnapshot.documents.forEach((docSnapshot) {
        retVal.add(NotesModel.fromDocumentSnapshot(docSnapshot));
      });
      return retVal;
    });
  }

  Future<void> updateNotes(
      String newContent, String uid, String notesId) async {
    try {
      _firestore
          .collection('users')
          .document(uid)
          .collection('notes')
          .document(notesId)
          .updateData({
        'content': newContent,
        'modifiedDate': Timestamp.now(),
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> delete(String noteId, String uid) async {
    try {
      _firestore
          .collection('users')
          .document(uid)
          .collection('notes')
          .document(noteId)
          .delete();
    } catch (e) {
      rethrow;
    }
  }
}
