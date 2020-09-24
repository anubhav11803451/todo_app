import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/animation/fadeanimation.dart';
import 'package:todo_app/animation/variousdisc.dart';
import 'package:todo_app/controllers/authcontroller.dart';
import 'package:todo_app/services/database.dart';
import 'package:todo_app/widgets/addNotes.dart';
import 'package:todo_app/widgets/addTodos.dart';
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
  final TextEditingController _notesContentController = TextEditingController();
  final TextEditingController _notesTitleController = TextEditingController();
  final TextEditingController _todoContentController = TextEditingController();
  final TextEditingController _todotitleController = TextEditingController();
  int selectedIndex = 1;
  int selectedIndexH = 0;
  List<int> index = [0, 1, 2];
  List<Icon> icons = [
    Icon(FontAwesomeIcons.home),
    Icon(FontAwesomeIcons.userAlt),
  ];

  Widget mybottomSheet(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Wrap(
        // crossAxisAlignment: WrapCrossAlignment.center,
        // runSpacing: 5,
        children: <Widget>[
          ListTile(
              leading: Icon(
                FontAwesomeIcons.penSquare,
                color: Colors.deepPurple[100],
              ),
              title: Text(
                'Note',
                style: GoogleFonts.indieFlower(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                setState(() {
                  swapWidget = AddNotes(
                    notesContentController: _notesContentController,
                    notesTitleController: _notesTitleController,
                  );
                  selectedIndex = index[2];
                  Get.back();
                });
              }),
          ListTile(
            leading: Icon(
              FontAwesomeIcons.clipboardCheck,
              color: Colors.deepPurple[100],
            ),
            title: Text(
              'Todo',
              style: GoogleFonts.indieFlower(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              setState(() {
                swapWidget = AddTodo(
                  todoContentController: _todoContentController,
                  todoTitleController: _todotitleController,
                );
                selectedIndex = index[2];
                Get.back();
              });
            },
          ),
        ],
      ),
    );
  }

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
      // margin: EdgeInsets.only(right: 10, left: 10),
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: icons[0],
            color: selectedIndex == index[0]
                ? Colors.deepPurple[100]
                : Colors.grey[600],
            onPressed: () {
              setState(() {
                selectedIndex = index[0];
                selectedIndexH = 0;
              });
              _notesTitleController.clear();
              _notesContentController.clear();
              _todoContentController.clear();
              _todotitleController.clear();
            },
            enableFeedback: true,
          ),
          GestureDetector(
            onLongPress: () {
              _authController.signOut();
            },
            child: IconButton(
              icon: icons[1],
              color: selectedIndex == index[1]
                  ? Colors.deepPurple[100]
                  : Colors.grey[600],
              onPressed: () {
                setState(() {
                  selectedIndex = index[1];
                  selectedIndex = 1;
                });
                _notesTitleController.clear();
                _notesContentController.clear();
                _todoContentController.clear();
                _todotitleController.clear();
              },
              enableFeedback: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget flotingButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        if (MediaQuery.of(context).viewInsets.bottom == 0) {
          Get.bottomSheet(mybottomSheet(context));
        } else if (_notesTitleController.text != '' &&
            _notesContentController.text != '' &&
            MediaQuery.of(context).viewInsets.bottom != 0) {
          Database().addNotes(_notesTitleController.text,
              _notesContentController.text, _authController.user.uid);
          _notesContentController.clear();
          _notesTitleController.clear();
          FocusScope.of(context).unfocus(); // helps to dipose keyboard
          setState(() {
            selectedIndex = index[0];
            selectedIndexH = 0;
          });
          Get.snackbar('Note Created', 'You can modify it later.',
              icon: Icon(FontAwesomeIcons.pen),
              snackPosition: SnackPosition.BOTTOM,
              overlayBlur: 0.5,
              duration: Duration(milliseconds: 800));
        } else if (_todotitleController.text != '' &&
            _todoContentController.text != '' &&
            MediaQuery.of(context).viewInsets.bottom != 0) {
          Database().addTodo(_todotitleController.text,
              _todoContentController.text, _authController.user.uid);
          _todoContentController.clear();
          _todotitleController.clear();
          FocusScope.of(context).unfocus(); // helps to dipose keyboard
          setState(() {
            selectedIndex = index[0];
            selectedIndexH = 1;
          });
          Get.snackbar('Todo added', 'When complete tick the checkbox.',
              icon: Icon(FontAwesomeIcons.pen),
              snackPosition: SnackPosition.BOTTOM,
              overlayBlur: 0.5,
              duration: Duration(milliseconds: 800));
        }
      },
      backgroundColor: Colors.deepPurple[100],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      tooltip:
          selectedIndex == 2 && MediaQuery.of(context).viewInsets.bottom != 0
              ? 'Save'
              : 'Create New',
      child: selectedIndex == 2 && MediaQuery.of(context).viewInsets.bottom != 0
          ? Icon(FontAwesomeIcons.check)
          : Icon(FontAwesomeIcons.pen),
    );
  }

  Widget swapWidget;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: FadeAnimation(0.2, bottomAppBar(context)),
      floatingActionButton: FadeAnimation(0.4, flotingButton(context)),
      floatingActionButtonLocation:
          (MediaQuery.of(context).viewInsets.bottom == 0)
              ? FloatingActionButtonLocation.centerDocked
              : FloatingActionButtonLocation.endFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      backgroundColor: Colors.deepPurple[100],
      body: Stack(
        children: [
          FadeAnimation(0.1, VariousDiscs(10, Colors.white30)),
          AnimatedSwitcher(
            duration: Duration(milliseconds: 800),
            child: selectedIndex == 0
                ? Homebody(
                    selectedIndex: selectedIndexH,
                  )
                : AnimatedSwitcher(
                    duration: Duration(milliseconds: 800),
                    child: selectedIndex == 1 ? Profile() : swapWidget,
                    switchOutCurve: Curves.easeOutSine,
                    switchInCurve: Curves.easeInSine,
                    transitionBuilder:
                        (Widget child, Animation<double> animation) =>
                            ScaleTransition(
                      scale: animation,
                      child: child,
                    ),
                  ),
            switchOutCurve: Curves.easeOutSine,
            switchInCurve: Curves.easeInOutSine,
            transitionBuilder: (Widget child, Animation<double> animation) =>
                ScaleTransition(
              scale: animation,
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
