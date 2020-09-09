import 'package:todo_app/controllers/notescontroller.dart';
import 'package:todo_app/screens/editNotes.dart';
import 'package:todo_app/widgets/notesCard.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget home(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return Container(
    key: UniqueKey(),
    height: size.height,
    width: size.width,
    padding: EdgeInsets.only(left: 10, right: 10, top: 30),
    child: Column(
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
                  padding: EdgeInsets.only(top: 20),
                  itemCount: notesController.notes.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      child:
                          NotesCard(notesModel: notesController.notes[index]),
                      onTap: () {
                        Get.to(
                          EditNotes(
                            initalValue: notesController.notes[index].content,
                            notesModel: notesController.notes[index],
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            } else {
              return Text(
                'Loading',
                style:
                    GoogleFonts.indieFlower(color: Colors.white, fontSize: 18),
              );
            }
          },
        ),
      ],
    ),
  );
}
