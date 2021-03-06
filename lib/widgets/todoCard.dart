import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/todomodel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/services/database.dart';
import 'package:todo_app/controllers/authcontroller.dart';

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
    return Container(
      decoration: BoxDecoration(
        color: widget.todoModel.done == true ? Colors.grey[300] : Colors.white,
        image: DecorationImage(
            image: AssetImage('assets/images/abstc.png'), fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            color: Colors.deepPurple[200],
            blurRadius: 15,
            spreadRadius: -5,
          ),
        ],
      ),
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: ExpansionTile(
          // backgroundColor: Colors.deepPurple[100],
          tilePadding: EdgeInsets.all(0),
          title: Text(
            widget.todoModel.title.capitalizeFirst,
            style: GoogleFonts.montserrat(),
          ),
          subtitle: Text(
            'Created at: ' +
                DateFormat('hh:mm a d MMM')
                    .format(widget.todoModel.dateCreated.toDate())
                    .toString(),
            style:
                GoogleFonts.montserrat(color: Colors.grey[600], fontSize: 13),
          ),
          leading: Checkbox(
            activeColor: Colors.deepPurple[100],
            value: widget.todoModel.done,
            onChanged: (newValue) {
              Database().updateTodo(
                  newValue, _authController.user.uid, widget.todoModel.todoId);
            },
          ),
          // trailing: IconButton(
          //   icon: Icon(
          //     FontAwesomeIcons.trash,
          //     size: 18,
          //   ),
          //   onPressed: () {
          //     Database().deleteTodo(
          //         widget.todoModel.todoId, _authController.user.uid);
          //   },
          // ),
          childrenPadding: EdgeInsets.all(5),
          children: [
            Text(
              widget.todoModel.content,
              style: GoogleFonts.montserrat(),
            ),
          ],
        ),
      ),
    );
  }
}
