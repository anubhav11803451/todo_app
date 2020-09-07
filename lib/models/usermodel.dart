import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid;
  String name, email;
  Timestamp accountCreated;

  UserModel({this.uid, this.name, this.email, this.accountCreated});

  UserModel.fromDocumentSnapshot({DocumentSnapshot documentSnapshot}) {
    uid = documentSnapshot.documentID;
    name = documentSnapshot["name"];
    email = documentSnapshot["email"];
    accountCreated = documentSnapshot["accountCreated"];
  }
}
