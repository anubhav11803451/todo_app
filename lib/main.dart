import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/screens/splashscreen.dart';
import 'package:todo_app/controllers/bindings/authbinding.dart';
import 'dart:io';

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
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
