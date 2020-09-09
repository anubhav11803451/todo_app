import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_app/controllers/authcontroller.dart';
import 'package:todo_app/models/notesmodel.dart';
import 'package:todo_app/services/database.dart';
import 'package:todo_app/widgets/addNotes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class EditNotes extends StatefulWidget {
  String initalValue;
  final NotesModel notesModel;
  EditNotes({Key key, this.initalValue, this.notesModel}) : super(key: key);

  @override
  _EditNotesState createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  final AuthController _authController = Get.put(AuthController());
  Widget flotingButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        if (Get.context.mediaQueryViewInsets.bottom != 0) {
          Database().updateNotes(widget.initalValue, _authController.user.uid,
              widget.notesModel.notesId);
          Get.snackbar('Notes Updated', 'Your notes are modified.',
              icon: Icon(FontAwesomeIcons.pen),
              snackPosition: SnackPosition.BOTTOM);
        } else {
          Database()
              .delete(widget.notesModel.notesId, _authController.user.uid);

          Get.snackbar('Note Deleted', 'Your notes are important.',
              icon: Icon(FontAwesomeIcons.pen),
              snackPosition: SnackPosition.BOTTOM);
        }
      },
      backgroundColor: Colors.deepPurple[100],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      tooltip:
          (Get.context.mediaQueryViewInsets.bottom != 0) ? 'Update' : 'Delete',
      child: (Get.context.mediaQueryViewInsets.bottom != 0)
          ? Icon(FontAwesomeIcons.check)
          : Icon(FontAwesomeIcons.trash),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: bottomAppBar(context),
      floatingActionButton: flotingButton(context),
      floatingActionButtonLocation:
          (MediaQuery.of(context).viewInsets.bottom == 0)
              ? FloatingActionButtonLocation.centerDocked
              : FloatingActionButtonLocation.endFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      backgroundColor: Colors.deepPurple[100],
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 800),
        child: AddNotes(
          intialValue: widget.initalValue,
          onChanged: (value) {
            if (value != '') {
              setState(() {
                widget.initalValue = value;
              });
              // Database().updateNotes(
              //     value, _authController.user.uid, widget.notesModel.notesId);
              // print(widget.initalValue);
            } else if (value == '') {
              setState(() {
                widget.initalValue = value;
              });
              // Database()
              //     .delete(widget.notesModel.notesId, _authController.user.uid);
              // Get.back();
            }
          },
        ),
        switchOutCurve: Curves.easeInOutCubic,
        switchInCurve: Curves.fastLinearToSlowEaseIn,
        transitionBuilder: (Widget child, Animation<double> animation) =>
            ScaleTransition(
          scale: animation,
          child: child,
        ),
      ),
    );
  }
}
