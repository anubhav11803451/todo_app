import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:todo_app/animation/variousdisc.dart';
import 'package:todo_app/screens/loginscreen.dart';
import 'package:todo_app/utils/root.dart';

class Splashscreen extends StatefulWidget {
  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SplashScreen(
          seconds: 3,
          backgroundColor: Colors.deepPurple[200],
          title: Text(
            'TODO',
            style: GoogleFonts.indieFlower(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              // color: Colors.wh,
            ),
          ),
          loaderColor: Colors.white54,
          navigateAfterSeconds: new Root(),
        ),
        VariousDiscs(10, Colors.white30),
      ],
    );
  }
}
