import 'package:flutter/material.dart';
import 'package:todo_app/utils/root.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:todo_app/animation/variousdisc.dart';

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
          backgroundColor: Colors.deepPurple[100],
          title: Text(
            '',
            style: GoogleFonts.indieFlower(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          loaderColor: Colors.white54,
          navigateAfterSeconds: Root(),
        ),
        VariousDiscs(10, Colors.white30),
      ],
    );
  }
}
