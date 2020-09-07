import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/services/database.dart';
import 'package:todo_app/controllers/authcontroller.dart';
import 'package:todo_app/controllers/usercontroller.dart';

class Homescreen extends StatefulWidget {
  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int selectedIndex = 1;
  List<int> index = [0, 1];
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
          bottomRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
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
            },
          ),
        ],
      ),
    );
  }

  Widget flotingButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: Colors.deepPurple[100],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      tooltip: 'Add Notes',
      child: Icon(FontAwesomeIcons.plus),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomAppBar(context),
      floatingActionButton: flotingButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      backgroundColor: Colors.deepPurple[100],
      body: IndexedStack(
        index: selectedIndex,
        key: UniqueKey(),
        sizing: StackFit.passthrough,
        children: [
          home(context),
          profile(context),
        ],
      ),
    );
  }
}

Widget home(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return Container(
    height: size.height,
    width: size.width,
  );
}

Widget profile(BuildContext context) {
  final AuthController _authController = Get.put(AuthController());
  Size size = MediaQuery.of(context).size;
  return Container(
    height: size.height,
    width: size.width,
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    child: GetX<UserController>(
      initState: (_) async {
        Get.find<UserController>().user =
            await Database().getUser(Get.find<AuthController>().user.uid);
      },
      builder: (_) {
        if (_.user.name != null) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Icon(FontAwesomeIcons.userAlt, size: 50),
              Text(
                'Hey !\n${_.user.name}',
                style: GoogleFonts.imprima(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70,
                ),
              ),
              FlatButton(
                onPressed: () {
                  _authController.signOut();
                },
                child: Text(
                  'Sign out',
                  style: GoogleFonts.indieFlower(
                    color: Colors.deepPurple[200],
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
            ),
          );
        }
      },
    ),
  );
}
