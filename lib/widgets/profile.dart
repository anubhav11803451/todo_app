import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/animation/fadeanimation.dart';
import 'package:todo_app/controllers/quotescontroller.dart';
import 'package:todo_app/services/database.dart';
import 'package:todo_app/controllers/authcontroller.dart';
import 'package:todo_app/controllers/usercontroller.dart';
import 'package:todo_app/widgets/quoteData.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  final QuotesController _quotesController = Get.put(QuotesController());
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
    } else if (DateTime.now().hour >= 12 && DateTime.now().hour < 16) {
      text = 'Good afternoon';
    } else if (DateTime.now().hour >= 16 && DateTime.now().hour < 22) {
      text = 'Good evening';
    } else {
      text = 'Good night';
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      key: UniqueKey(),
      height: size.height,
      width: size.width,
      padding: EdgeInsets.fromLTRB(10, 15, 10, 60),
      child: GetX(
        initState: (_) async {
          Get.find<UserController>().user =
              await Database().getUser(Get.find<AuthController>().user.uid);
        },
        builder: (UserController userController) {
          if (userController.user.name != null) {
            return Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    'assets/images/asd.png',
                    height: 330,
                    color: Colors.black45,
                    alignment: Alignment.topCenter,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FadeAnimation(
                      0.6,
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
                              text: userController.user.name,
                              style: GoogleFonts.montserratAlternates(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black38,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    FadeAnimation(
                      1.0,
                      Center(
                        child: QuoteData(
                          qoutemodel: _quotesController.quotemodel,
                        ),
                      ),
                    ),
                    // FadeAnimation(
                    //   0.8,
                    //   Align(
                    //     alignment: Alignment.bottomRight,
                    //     child: FlatButton(
                    //       onPressed: () {
                    //         _authController.signOut();
                    //       },
                    //       child: Text(
                    //         'Sign out',
                    //         style: GoogleFonts.indieFlower(
                    //           color: Colors.redAccent,
                    //           fontSize: 20,
                    //           fontWeight: FontWeight.bold,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
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
