import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/services/database.dart';
import 'package:todo_app/controllers/authcontroller.dart';
import 'package:todo_app/controllers/usercontroller.dart';

class Homescreen extends StatelessWidget {
  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Userinfo(),
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

class Userinfo extends StatelessWidget {
  const Userinfo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<UserController>(
      initState: (_) async {
        Get.find<UserController>().user =
            await Database().getUser(Get.find<AuthController>().user.uid);
      },
      builder: (_) {
        if (_.user.name != null) {
          return Text("Welcome " + _.user.name);
        } else {
          return LinearProgressIndicator();
        }
      },
    );
  }
}
