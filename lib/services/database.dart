import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/models/user.dart';

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
}
