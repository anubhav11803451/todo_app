import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/controllers/notescontroller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

Widget home(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return Container(
    key: UniqueKey(),
    height: size.height,
    width: size.width,
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GetX<NotesController>(
          init: Get.put<NotesController>(NotesController()),
          builder: (NotesController notesController) {
            if (notesController != null && notesController.notes != null) {
              return Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: notesController.notes.length,
                  itemBuilder: (BuildContext context, int index) {
                    return NotesCard(
                      content: notesController.notes[index].content.length >= 50
                          ? notesController.notes[index].content
                              .substring(0, 40)
                              .capitalizeFirst(
                                  notesController.notes[index].content)
                          : notesController.notes[index].content
                              .capitalizeFirst(
                                  notesController.notes[index].content),
                      date: DateFormat.yMMMd('en_US')
                          .format(
                              notesController.notes[index].dateCreated.toDate())
                          .toString(),
                    );
                  },
                ),
              );
            } else {
              return Text('Loading..');
            }
          },
        ),
      ],
    ),
  );
}

class NotesCard extends StatelessWidget {
  final String content, date;
  const NotesCard({
    Key key,
    this.content,
    this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: GridTile(
        child: Text(content, style: GoogleFonts.montserratAlternates()),
        footer: Text('created at : $date',
            style: GoogleFonts.montserrat(color: Colors.grey)),
      ),
    );
  }
}
