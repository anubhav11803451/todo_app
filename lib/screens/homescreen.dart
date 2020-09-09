import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/authcontroller.dart';
import 'package:todo_app/services/database.dart';
import 'package:todo_app/widgets/addNotes.dart';
import 'package:todo_app/widgets/profile.dart';
import 'package:todo_app/widgets/home.dart';
import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  Homescreen({Key key}) : super(key: key);
  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final AuthController _authController = Get.put(AuthController());
  final TextEditingController _notesController = TextEditingController();
  int selectedIndex = 1;
  List<int> index = [0, 1, 2];
  List<Icon> icons = [
    Icon(FontAwesomeIcons.tasks),
    Icon(FontAwesomeIcons.userAlt),
  ];

  Widget bottomAppBar(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.width * 0.153,
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -2),
            color: Colors.deepPurple[200],
            blurRadius: 20,
            spreadRadius: -5,
          ),
        ],
      ),
      margin: EdgeInsets.only(right: 10, left: 10),
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: icons[0],
            color: selectedIndex == index[0]
                ? Colors.deepPurple[100]
                : Colors.grey,
            onPressed: () {
              setState(() {
                selectedIndex = index[0];
              });
              _notesController.clear();
            },
          ),
          IconButton(
            icon: icons[1],
            color: selectedIndex == index[1]
                ? Colors.deepPurple[100]
                : Colors.grey,
            onPressed: () {
              setState(() {
                selectedIndex = index[1];
              });
              _notesController.clear();
            },
          ),
        ],
      ),
    );
  }

  Widget flotingButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        setState(() {
          selectedIndex = index[2];
        });
        if (_notesController.text != '') {
          Database().addTodos(_notesController.text, _authController.user.uid);
          _notesController.clear();
          FocusScope.of(context).unfocus(); // helps to dipose keyboard
          setState(() {
            selectedIndex = index[0];
          });
          Get.snackbar('Note Created', 'You can modify it later.',
              icon: Icon(FontAwesomeIcons.pen),
              snackPosition: SnackPosition.BOTTOM);
        } else if (MediaQuery.of(context).viewInsets.bottom != 0) {
          Get.snackbar('No Content', 'Write something to create note.',
              icon: Icon(FontAwesomeIcons.pen),
              snackPosition: SnackPosition.BOTTOM);
        }
      },
      backgroundColor: Colors.deepPurple[100],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      tooltip: selectedIndex == 2 ? 'Add Notes' : 'Create New',
      child: selectedIndex == 2
          ? Icon(FontAwesomeIcons.check)
          : Icon(FontAwesomeIcons.plus),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomAppBar(context),
      floatingActionButton: flotingButton(context),
      floatingActionButtonLocation:
          (MediaQuery.of(context).viewInsets.bottom == 0)
              ? FloatingActionButtonLocation.centerDocked
              : FloatingActionButtonLocation.endFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      backgroundColor: Colors.deepPurple[100],
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 800),
        child: selectedIndex == 0
            ? home(context)
            : AnimatedSwitcher(
                duration: Duration(milliseconds: 800),
                child: selectedIndex == 1
                    ? Profile()
                    : AddNotes(notesController: _notesController),
                switchOutCurve: Curves.easeInOutCubic,
                switchInCurve: Curves.fastLinearToSlowEaseIn,
                transitionBuilder:
                    (Widget child, Animation<double> animation) =>
                        ScaleTransition(
                  scale: animation,
                  child: child,
                ),
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
