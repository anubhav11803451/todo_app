import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/controllers/authcontroller.dart';
import 'package:todo_app/controllers/usercontroller.dart';
import 'package:todo_app/services/database.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  final AuthController _authController = Get.put(AuthController());
  AnimationController _animationController;
  Animation<Color> _colorTween;
  String text;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _colorTween = _animationController
        .drive(ColorTween(begin: Colors.deepPurple[100], end: Colors.white));
    if (DateTime.now().hour < 12) {
      text = 'Good morning';
    } else if (DateTime.now().hour >= 12 && DateTime.now().hour < 18) {
      text = 'Good afternoon';
    } else {
      text = 'Good evening';
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      key: UniqueKey(),
      height: size.height,
      width: size.width,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: GetX<UserController>(
        initState: (_) async {
          Get.find<UserController>().user =
              await Database().getUser(Get.find<AuthController>().user.uid);
        },
        builder: (_) {
          if (_.user.name != null) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RichText(
                  text: TextSpan(
                    text: '$text,\n',
                    style: GoogleFonts.montserratAlternates(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: _.user.name,
                        style: GoogleFonts.montserratAlternates(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                        ),
                      )
                    ],
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    _authController.signOut();
                  },
                  child: Text(
                    'Sign out',
                    style: GoogleFonts.indieFlower(
                      color: Colors.black38,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
                valueColor: _colorTween,
              ),
            );
          }
        },
      ),
    );
  }
}
