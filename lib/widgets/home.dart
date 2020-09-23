import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/widgets/todoCard.dart';
import 'package:todo_app/widgets/notesCard.dart';
import 'package:todo_app/screens/editNotes.dart';
import 'package:todo_app/controllers/todocontroller.dart';
import 'package:todo_app/controllers/notescontroller.dart';

class Homebody extends StatefulWidget {
  Homebody({Key key}) : super(key: key);

  @override
  _HomebodyState createState() => _HomebodyState();
}

class _HomebodyState extends State<Homebody> {
  final TodoController todoController = Get.put(TodoController());

  int selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      key: UniqueKey(),
      height: size.height,
      width: size.width,
      padding: EdgeInsets.only(left: 10, right: 10, top: 25),
      child: GetX(
        // initState: (_) {
        //   Get.put<TodoController>(TodoController());
        // },
        init: Get.put<NotesController>(NotesController()),
        builder: (NotesController notesController) {
          if (notesController != null && notesController.notes != null) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = 0;
                        });
                      },
                      child: Text(
                        'Notes',
                        style: GoogleFonts.indieFlower(
                            fontSize: selectedIndex == 0 ? 20 : 16,
                            color:
                                selectedIndex == 0 ? Colors.white : Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = 1;
                        });
                      },
                      child: Text(
                        'Todo\'s',
                        style: GoogleFonts.indieFlower(
                            fontSize: selectedIndex == 1 ? 20 : 16,
                            color:
                                selectedIndex == 1 ? Colors.white : Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  // child: Text('data'),
                  child: selectedIndex == 0
                      ? GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          padding: EdgeInsets.only(top: 10),
                          itemCount: notesController.notes.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              child: NotesCard(
                                  notesModel: notesController.notes[index]),
                              onTap: () {
                                Get.to(
                                  EditNotes(
                                    initalValue:
                                        notesController.notes[index].content,
                                    notesModel: notesController.notes[index],
                                  ),
                                );
                              },
                            );
                          },
                        )
                      : ListView.builder(
                          padding: EdgeInsets.only(top: 10),
                          itemCount: todoController.todos.length,
                          itemBuilder: (BuildContext context, int index) {
                            return TodoCard(
                                todoModel: todoController.todos[index]);
                          },
                        ),
                ),
              ],
            );
          } else {
            return Text(
              'Loading...',
              style: GoogleFonts.indieFlower(color: Colors.white, fontSize: 18),
            );
          }
        },
      ),
    );
  }
}
