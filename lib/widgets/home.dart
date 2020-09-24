import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/widgets/todoCard.dart';
import 'package:todo_app/widgets/notesCard.dart';
import 'package:todo_app/screens/editNotes.dart';
import 'package:todo_app/controllers/todocontroller.dart';
import 'package:todo_app/controllers/notescontroller.dart';

// ignore: must_be_immutable
class Homebody extends StatefulWidget {
  int selectedIndex;
  Homebody({Key key, this.selectedIndex = 1}) : super(key: key);

  @override
  _HomebodyState createState() => _HomebodyState();
}

class _HomebodyState extends State<Homebody> {
  final TodoController todoController = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      key: UniqueKey(),
      // height: size.height,
      width: size.width,
      padding: EdgeInsets.only(left: 10, right: 10, top: 22),
      child: GetX(
        initState: (_) {
          Get.put<TodoController>(TodoController());
        },
        init: Get.put<NotesController>(NotesController()),
        builder: (NotesController notesController) {
          if (notesController != null &&
              notesController.notes != null &&
              todoController != null &&
              todoController.todos != null) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.selectedIndex = 0;
                          });
                        },
                        child: Text(
                          'Notes',
                          style: GoogleFonts.indieFlower(
                              fontSize: widget.selectedIndex == 0 ? 20 : 16,
                              color: widget.selectedIndex == 0
                                  ? Colors.white
                                  : Colors.grey[600],
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.selectedIndex = 1;
                          });
                        },
                        child: Text(
                          'Todo\'s',
                          style: GoogleFonts.indieFlower(
                              fontSize: widget.selectedIndex == 1 ? 20 : 16,
                              color: widget.selectedIndex == 1
                                  ? Colors.white
                                  : Colors.grey[600],
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  // child: Text('data'),
                  child: widget.selectedIndex == 0
                      ? GridView.builder(
                          // key: UniqueKey(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          padding: EdgeInsets.only(top: 5),
                          itemCount: notesController.notes.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              child: NotesCard(
                                  key: UniqueKey(),
                                  notesModel: notesController.notes[index]),
                              onTap: () {
                                Get.to(
                                  EditNotes(
                                    initalTitleValue:
                                        notesController.notes[index].title,
                                    initalContentValue:
                                        notesController.notes[index].content,
                                    notesModel: notesController.notes[index],
                                  ),
                                );
                              },
                            );
                          },
                        )
                      : ListView.builder(
                          // key: UniqueKey(),
                          padding: EdgeInsets.only(top: 10),
                          itemCount: todoController.todos.length,
                          itemBuilder: (BuildContext context, int index) {
                            return TodoCard(
                                key: UniqueKey(),
                                todoModel: todoController.todos[index]);
                          },
                        ),
                ),
              ],
            );
          } else {
            return Center(
              child: Text(
                'Loading...',
                style:
                    GoogleFonts.indieFlower(color: Colors.white, fontSize: 18),
              ),
            );
          }
        },
      ),
    );
  }
}
