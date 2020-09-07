import 'package:cloud_firestore/cloud_firestore.dart';

class NotesModel {
  String content, notesId;
  Timestamp dateCreated;
  bool done;

  NotesModel({this.content, this.dateCreated, this.done, this.notesId});

  NotesModel.fromDocumentSnapshot(DocumentSnapshot docSnapshot) {
    notesId = docSnapshot.documentID;
    content = docSnapshot.data['content'];
    dateCreated = docSnapshot.data['dateCreated'];
    done = docSnapshot.data['done'];
  }
}
