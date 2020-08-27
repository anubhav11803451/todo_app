import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/authcontroller.dart';
import 'package:todo_app/screens/homescreen.dart';
import 'package:todo_app/screens/loginscreen.dart';

class Root extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return (Get.find<AuthController>().user != null)
            ? Homescreen()
            : Loginscreen();
      },
    );
  }
}
