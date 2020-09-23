import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/controllers/authcontroller.dart';
import 'package:todo_app/models/todomodel.dart';
import 'package:todo_app/services/database.dart';

class TodoCard extends StatefulWidget {
  final TodoModel todoModel;
  const TodoCard({Key key, this.todoModel}) : super(key: key);

  @override
  _TodoCardState createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  final AuthController _authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          widget.todoModel.content,
          style: GoogleFonts.montserrat(),
        ),
        subtitle: Text(
          'Created at: ' +
              DateFormat('hh:mm a d MMM')
                  .format(widget.todoModel.dateCreated.toDate())
                  .toString(),
          style: GoogleFonts.montserrat(),
        ),
        trailing: Checkbox(
          activeColor: Colors.deepPurple[200],
          value: widget.todoModel.done,
          onChanged: (newValue) {
            Database().updateTodo(
                newValue, _authController.user.uid, widget.todoModel.todoId);
          },
        ),
      ),
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 20),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: widget.todoModel.done == true ? Colors.grey[300] : Colors.white,
    );
  }
}
