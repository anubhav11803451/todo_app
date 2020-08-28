import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/controllers/authcontroller.dart';
import 'package:todo_app/widgets/inputbox.dart';
import 'package:todo_app/screens/signupscreen.dart';
import 'package:todo_app/animation/variousdisc.dart';
import 'package:todo_app/animation/fadeanimation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Loginscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Loginbody(),
      backgroundColor: Colors.deepPurple[200],
    );
  }
}

class Loginbody extends StatefulWidget {
  // IconData icon = FontAwesomeIcons.eyeSlash;
  // AuthController _authController = Get.put(AuthController());
  @override
  _LoginbodyState createState() => _LoginbodyState();
}

class _LoginbodyState extends State<Loginbody> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final AuthController _authController = Get.put(AuthController());
  bool value = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.fromLTRB(20, 40, 20, 40),
      alignment: Alignment.center,
      child: Stack(
        children: [
          FadeAnimation(1.2, VariousDiscs(10, Colors.white30)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Login text
              FadeAnimation(
                0.2,
                Text(
                  'Login',
                  style: GoogleFonts.indieFlower(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 40),
              //email inputbox
              FadeAnimation(
                0.4,
                Inputbox(
                  controller: _emailController,
                  hintText: 'Email',
                  hintStyle: GoogleFonts.indieFlower(),
                  icon: Icon(
                    Icons.alternate_email,
                    color: Colors.white54,
                  ),
                  boxColor: Colors.white24,
                ),
              ),
              //password inputbox
              FadeAnimation(
                0.6,
                Inputbox(
                  controller: _passwordController,
                  hintText: 'Password',
                  hintStyle: GoogleFonts.indieFlower(),
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
              ),
              //forgot pass flatbutton
              FadeAnimation(
                0.8,
                Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () {},
                    child: Text('Forgot Password',
                        style: GoogleFonts.indieFlower()),
                    textColor: Colors.black54,
                  ),
                ),
              ),
              //circularavtar iconbutton
              FadeAnimation(
                1.0,
                CircleAvatar(
                  backgroundColor: Colors.white24,
                  radius: 28,
                  child: IconButton(
                    icon:
                        Icon(FontAwesomeIcons.arrowRight, color: Colors.white),
                    onPressed: () {
                      _authController.login(
                        _emailController.text,
                        _passwordController.text,
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              //signup button
              FadeAnimation(
                1.4,
                GestureDetector(
                  child: Text('Signup',
                      style: GoogleFonts.indieFlower(fontSize: 20)),
                  onTap: () {
                    Get.to(Signupscreen());
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
