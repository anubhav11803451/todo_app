import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/models/notesmodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class NotesCard extends StatelessWidget {
  final String content, date;
  final NotesModel notesModel;
  const NotesCard({
    Key key,
    this.content,
    this.date,
    this.notesModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple[200],
            blurRadius: 20,
            spreadRadius: -5,
          ),
        ],
      ),
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 20),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: GridTile(
        child: Text(
          notesModel.content.length >= 50
              ? notesModel.content
                  .substring(0, 40)
                  .capitalizeFirst(notesModel.content)
              : notesModel.content.capitalizeFirst(notesModel.content),
          style: GoogleFonts.montserratAlternates(
            // color: Colors.deepPurple[400].withOpacity(0.7),
            fontSize: 15,
          ),
        ),
        footer: Text(
          notesModel.modifiedDate.isNull
              ? 'Created at: ' +
                  DateFormat('hh:mm a\nd MMM')
                      .format(notesModel.dateCreated.toDate())
                      .toString()
              : 'Modified at: ' +
                  DateFormat('hh:mm a\nd MMM')
                      .format(notesModel.modifiedDate.toDate())
                      .toString(),
          style: GoogleFonts.montserrat(color: Colors.grey, fontSize: 12),
        ),
      ),
    );
  }
}
