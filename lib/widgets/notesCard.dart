import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/models/notesmodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class NotesCard extends StatelessWidget {
  final NotesModel notesModel;
  const NotesCard({
    Key key,
    this.notesModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Card(
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 20),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Container(
        // key: UniqueKey(),
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/abstc.png')),
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 4),
              color: Colors.deepPurple[200],
              blurRadius: 15,
              spreadRadius: -5,
            ),
          ],
        ),
        // margin: EdgeInsets.only(left: 10, right: 10, bottom: 20),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: GridTile(
          child: Text(
            notesModel.title.length >= 50
                ? notesModel.title.substring(0, 40).capitalizeFirst
                : notesModel.title.capitalizeFirst,
            style: GoogleFonts.montserratAlternates(
              // color: Colors.deepPurple[400].withOpacity(0.7),
              fontSize: 15,
            ),
          ),
          footer: Text(
            notesModel.modifiedDate == null
                ? 'Created at: ' +
                    DateFormat('hh:mm a\nd MMM')
                        .format(notesModel.dateCreated.toDate())
                        .toString()
                : 'Modified at: ' +
                    DateFormat('hh:mm a\nd MMM')
                        .format(notesModel.modifiedDate.toDate())
                        .toString(),
            style:
                GoogleFonts.montserrat(color: Colors.grey[600], fontSize: 12),
          ),
        ),
      ),
    );
  }
}
