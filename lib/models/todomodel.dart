import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String content, title;
  String todoId;
  Timestamp dateCreated;
  bool done;

  TodoModel(
    this.content,
    this.title,
    this.todoId,
    this.dateCreated,
    this.done,
  );

  TodoModel.fromDocumentSnapshot(
    DocumentSnapshot documentSnapshot,
  ) {
    todoId = documentSnapshot.documentID;
    title = documentSnapshot.data["title"];
    content = documentSnapshot.data["content"];
    dateCreated = documentSnapshot.data["dateCreated"];
    done = documentSnapshot.data["done"];
  }
}
