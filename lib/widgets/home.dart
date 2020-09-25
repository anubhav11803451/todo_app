import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/controllers/authcontroller.dart';
import 'package:todo_app/services/database.dart';
import 'package:todo_app/widgets/todoCard.dart';
import 'package:todo_app/widgets/notesCard.dart';
import 'package:todo_app/screens/editNotes.dart';
import 'package:todo_app/controllers/todocontroller.dart';
import 'package:todo_app/controllers/notescontroller.dart';

// ignore: must_be_immutable
class Homebody extends StatefulWidget {
  int selectedIndex;
  Homebody({Key key, this.selectedIndex}) : super(key: key);

  @override
  _HomebodyState createState() => _HomebodyState();
}

class _HomebodyState extends State<Homebody> {
  final TodoController todoController = Get.put(TodoController());
  final AuthController _authController = Get.put(AuthController());
  Key n1 = GlobalKey();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnimatedContainer(
      key: UniqueKey(),
      // height: size.height,
      width: size.width,
      padding: EdgeInsets.only(left: 10, right: 10, top: 22),
      duration: Duration(milliseconds: 1000),
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
                            return Dismissible(
                              key: Key(notesController.notes[index].toString()),
                              child: GestureDetector(
                                child: Hero(
                                  tag: notesController.notes[index],
                                  child: NotesCard(
                                    notesModel: notesController.notes[index],
                                  ),
                                  transitionOnUserGestures: true,
                                ),
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
                              ),
                              background: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.redAccent,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  margin: EdgeInsets.only(
                                      left: 10, right: 10, bottom: 20)),
                              onDismissed: (direction) {
                                Database().deleteNotes(
                                    notesController.notes[index].notesId,
                                    _authController.user.uid);
                                setState(() {
                                  notesController.notes.removeAt(index);
                                });

                                Get.snackbar(
                                  'Note Deleted',
                                  'Your notes are important.',
                                  icon: Icon(FontAwesomeIcons.pen),
                                  snackPosition: SnackPosition.BOTTOM,
                                  overlayBlur: 0.5,
                                  duration: Duration(milliseconds: 800),
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
                            return Dismissible(
                              key: Key(todoController.todos[index].toString()),
                              child: TodoCard(
                                todoModel: todoController.todos[index],
                              ),
                              background: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.redAccent,
                                ),
                                margin: EdgeInsets.only(
                                    left: 10, right: 10, bottom: 20),
                              ),
                              onDismissed: (direction) {
                                Database().deleteTodo(
                                    todoController.todos[index].todoId,
                                    _authController.user.uid);
                                Get.snackbar(
                                  'Todo Deleted',
                                  'Your Todo\'s are important.',
                                  icon: Icon(FontAwesomeIcons.pen),
                                  snackPosition: SnackPosition.BOTTOM,
                                  overlayBlur: 0.5,
                                  duration: Duration(milliseconds: 800),
                                );
                              },
                            );
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
