import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/controllers/usercontroller.dart';
import 'package:todo_app/screens/homescreen.dart';
import 'package:todo_app/screens/loginscreen.dart';
import 'package:todo_app/controllers/authcontroller.dart';

class Root extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    return GetX(
      initState: (_) async {
        Get.put<UserController>(UserController());
      },
      builder: (_) {
        if (Get.find<AuthController>().user?.uid != null) {
          return Homescreen();
        } else {
          return Loginscreen();
        }
      },
    );
  }
}
