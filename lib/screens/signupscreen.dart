import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_app/controllers/authcontroller.dart';
import 'package:todo_app/widgets/inputbox.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/animation/variousdisc.dart';
import 'package:todo_app/animation/fadeanimation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Signupscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Signupbody(),
      backgroundColor: Colors.deepPurple[100],
    );
  }
}

class Signupbody extends StatefulWidget {
  @override
  _SignupbodyState createState() => _SignupbodyState();
}

class _SignupbodyState extends State<Signupbody> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmpasswordController = TextEditingController();
  TextEditingController _name = TextEditingController();

  final AuthController _authController = Get.put(AuthController());
  bool value = true;

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
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
                  'SignUp',
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
                  controller: _name,
                  hintText: 'Name',
                  hintStyle: GoogleFonts.indieFlower(),
                  icon: Icon(
                    Icons.person,
                    color: Colors.black26,
                  ),
                  boxColor: Colors.white24,
                ),
              ),
              FadeAnimation(
                0.6,
                Inputbox(
                  controller: _emailController,
                  hintText: 'Email',
                  hintStyle: GoogleFonts.indieFlower(),
                  icon: Icon(
                    Icons.alternate_email,
                    color: Colors.black26,
                  ),
                  boxColor: Colors.white24,
                ),
              ),
              //password inputbox
              FadeAnimation(
                0.8,
                Inputbox(
                  controller: _passwordController,
                  hintText: 'Password',
                  hintStyle: GoogleFonts.indieFlower(),
                  obscure: value,
                  icon: Icon(Icons.lock_outline, color: Colors.black26),
                  suffixIcon: GestureDetector(
                    child: value == true
                        ? Icon(FontAwesomeIcons.eyeSlash,
                            size: 18, color: Colors.black26)
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
              FadeAnimation(
                1,
                Inputbox(
                  controller: _confirmpasswordController,
                  hintText: 'Confirm Password',
                  hintStyle: GoogleFonts.indieFlower(),
                  obscure: value,
                  icon: Icon(Icons.lock_outline, color: Colors.black26),
                  suffixIcon: value == true
                      ? Icon(FontAwesomeIcons.eyeSlash,
                          size: 18, color: Colors.black26)
                      : Icon(FontAwesomeIcons.eye,
                          size: 18, color: Colors.red[300]),
                  boxColor: Colors.white24,
                ),
              ),

              SizedBox(height: 20),
              //circularavtar iconbutton
              FadeAnimation(
                1.2,
                CircleAvatar(
                  backgroundColor: Colors.white24,
                  radius: 28,
                  child: IconButton(
                    icon:
                        Icon(FontAwesomeIcons.arrowRight, color: Colors.white),
                    onPressed: () {
                      if (_passwordController.text ==
                          _confirmpasswordController.text) {
                        _authController.createUser(
                          _emailController.text,
                          _passwordController.text,
                          _name.text,
                        );
                      } else {
                        Get.snackbar(
                          "Password doesn't match",
                          'Check the password again',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.white38,
                          overlayBlur: 1,
                        );
                      }
                    },
                  ),
                ),
              ),

              //signup button
              // FadeAnimation(
              //   1.4,
              //   GestureDetector(
              //     child: Text('Signup',
              //         style: GoogleFonts.indieFlower(fontSize: 20)),
              //     onTap: () {
              //       Get.to(Signupscreen());
              //     },
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
