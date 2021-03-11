import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/models/notesmodel.dart';
import 'package:todo_app/models/todomodel.dart';
import 'package:todo_app/models/usermodel.dart';
import 'package:get/get.dart';

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

  Future<void> addNotes(String title, String content, String uid) async {
    try {
      await _firestore
          .collection('users')
          .document(uid)
          .collection('notes')
          .add({
        'title': title,
        'content': content,
        'dateCreated': Timestamp.now(),
        // 'done': false,
      });
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Stream<List<NotesModel>> notesStream(String uid) {
    return _firestore
        .collection('users')
        .document(uid)
        .collection('notes')
        .orderBy('dateCreated', descending: true)
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<NotesModel> retVal = [];
      querySnapshot.documents.forEach((docSnapshot) {
        retVal.add(NotesModel.fromDocumentSnapshot(docSnapshot));
      });
      return retVal;
    });
  }

  Future<void> updateNotes(
      String newTitle, String newContent, String uid, String notesId) async {
    try {
      _firestore
          .collection('users')
          .document(uid)
          .collection('notes')
          .document(notesId)
          .updateData({
        'title': newTitle,
        'content': newContent,
        'modifiedDate': Timestamp.now(),
      });
      Get.back();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> deleteNotes(String noteId, String uid) async {
    try {
      _firestore
          .collection('users')
          .document(uid)
          .collection('notes')
          .document(noteId)
          .delete();
      Get.back();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addTodo(String title, String content, String uid) async {
    try {
      await _firestore
          .collection("users")
          .document(uid)
          .collection("todos")
          .add({
        'dateCreated': Timestamp.now(),
        'title': title,
        'content': content,
        'done': false,
      });
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Stream<List<TodoModel>> todoStream(String uid) {
    return _firestore
        .collection("users")
        .document(uid)
        .collection("todos")
        .orderBy("dateCreated", descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<TodoModel> retVal = [];
      query.documents.forEach((element) {
        retVal.add(TodoModel.fromDocumentSnapshot(element));
      });
      return retVal;
    });
  }

  Future<void> updateTodo(bool newValue, String uid, String todoId) async {
    try {
      _firestore
          .collection("users")
          .document(uid)
          .collection("todos")
          .document(todoId)
          .updateData({"done": newValue});
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> deleteTodo(String todoId, String uid) async {
    try {
      _firestore
          .collection("users")
          .document(uid)
          .collection("todos")
          .document(todoId)
          .delete();
      Get.back();
    } catch (e) {
      rethrow;
    }
  }
}
