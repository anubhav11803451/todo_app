import 'package:cloud_firestore/cloud_firestore.dart';

class NotesModel {
  String content, notesId;
  Timestamp dateCreated, modifiedDate;
  bool done;

  NotesModel({this.content, this.dateCreated, this.done, this.notesId});

  NotesModel.fromDocumentSnapshot(DocumentSnapshot docSnapshot) {
    notesId = docSnapshot.documentID;
    content = docSnapshot.data['content'];
    dateCreated = docSnapshot.data['dateCreated'];
    modifiedDate = docSnapshot.data['modifiedDate'];
    done = docSnapshot.data['done'];
  }
}
