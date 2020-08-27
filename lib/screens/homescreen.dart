import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/authcontroller.dart';

class Homescreen extends StatelessWidget {
  final AuthController _authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: FlatButton(
              onPressed: () {
                _authController.signOut();
              },
              child: Text('Sign Out'),
            ),
          ),
        ],
      ),
    );
  }
}
