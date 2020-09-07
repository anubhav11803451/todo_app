import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/controllers/authcontroller.dart';
import 'package:todo_app/controllers/usercontroller.dart';
import 'package:todo_app/services/database.dart';

Widget profile(BuildContext context) {
  final AuthController _authController = Get.put(AuthController());
  Size size = MediaQuery.of(context).size;
  return Container(
    key: UniqueKey(),
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
                'Hey !\n${_.user.name}\nit\'s\n${DateFormat.yMMMEd('en_US').format(DateTime.now())}',
                style: GoogleFonts.montserratAlternates(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              FlatButton(
                onPressed: () {
                  _authController.signOut();
                },
                child: Text(
                  'Sign out',
                  style: GoogleFonts.indieFlower(
                    color: Colors.white70,
                    fontSize: 20,
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
