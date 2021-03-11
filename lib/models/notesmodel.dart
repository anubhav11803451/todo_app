import 'package:cloud_firestore/cloud_firestore.dart';

class NotesModel {
  String content, notesId, title;
  Timestamp dateCreated, modifiedDate;
  bool done;

  NotesModel(
      {this.title, this.content, this.dateCreated, this.done, this.notesId});

  NotesModel.fromDocumentSnapshot(DocumentSnapshot docSnapshot) {
    notesId = docSnapshot.documentID;
    title = docSnapshot.data['title'];
    content = docSnapshot.data['content'];
    dateCreated = docSnapshot.data['dateCreated'];
    modifiedDate = docSnapshot.data['modifiedDate'];
    done = docSnapshot.data['done'];
  }
}
