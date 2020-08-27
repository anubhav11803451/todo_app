import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/screens/splashscreen.dart';
import 'package:todo_app/controllers/bindings/authbinding.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AuthBinding(),
      debugShowCheckedModeBanner: false,
      home: Splashscreen(),
    );
  }
}
