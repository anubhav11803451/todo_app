import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/widgets/inputbox.dart';

class Loginscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loginbody(),
      backgroundColor: Colors.deepPurple[200],
    );
  }
}

// ignore: camel_case_types
class loginbody extends StatefulWidget {
  @override
  _loginbodyState createState() => _loginbodyState();
}

// ignore: camel_case_types
class _loginbodyState extends State<loginbody> {
  // IconData icon = FontAwesomeIcons.eyeSlash;
  bool value = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.fromLTRB(20, 40, 20, 40),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Inputbox(
            hintText: 'Email',
            hintStyle: GoogleFonts.montserrat(),
            icon: Icon(
              Icons.alternate_email,
              color: Colors.white54,
            ),
            boxColor: Colors.white24,
          ),
          Inputbox(
            hintText: 'Password',
            hintStyle: GoogleFonts.montserrat(),
            obscure: value,
            icon: Icon(Icons.lock_outline, color: Colors.white54),
            suffixIcon: GestureDetector(
              child: value == true
                  ? Icon(FontAwesomeIcons.eyeSlash,
                      size: 18, color: Colors.white54)
                  : Icon(FontAwesomeIcons.eye,
                      size: 18, color: Colors.red[300]),
              onTap: () {
                setState(() {
                  if (value == true) {
                    value = false;
                  } else {
                    value = true;
                  }
                });
              },
            ),
            boxColor: Colors.white24,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: FlatButton(
              onPressed: () {},
              child: Text(
                'Forgot Password',
                style: GoogleFonts.montserrat(),
              ),
              textColor: Colors.black38,
            ),
          ),
          IconButton(
            icon: Icon(
              FontAwesomeIcons.arrowRight,
              color: Colors.white60,
            ),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
