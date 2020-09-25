import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/usercontroller.dart';
import 'package:todo_app/models/usermodel.dart';
import 'package:todo_app/services/database.dart';
import 'package:todo_app/utils/root.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Rx<FirebaseUser> _firebaseUser = Rx<FirebaseUser>();

  FirebaseUser get user => _firebaseUser.value;

  @override
  void onInit() {
    _firebaseUser.bindStream(_auth.onAuthStateChanged);
  }

  void createUser(String email, String password, String name) async {
    try {
      if (email != '' && password != '') {
        Get.snackbar('Signing Up', 'Please wait...',
            icon: Icon(FontAwesomeIcons.pen),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.white38,
            duration: Duration(milliseconds: 900),
            overlayBlur: 1);
      }

      AuthResult _authResult = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      // create userc in firestore
      UserModel _user = UserModel(
        uid: _authResult.user.uid,
        name: name,
        email: _authResult.user.email,
      );
      if (await Database().createNewuser(_user)) {
        Get.find<UserController>().user = _user;
        Get.to(Root());
      }
    } catch (e) {
      Get.snackbar(
        "Error while Signing Up",
        e.message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white38,
        duration: Duration(milliseconds: 900),
        overlayBlur: 1,
      );
    }
  }

  void login(String email, String password) async {
    try {
      if (email != '' && password != '') {
        Get.snackbar('Signing In', 'Please wait...',
            icon: Icon(FontAwesomeIcons.pen),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.white38,
            duration: Duration(milliseconds: 900),
            overlayBlur: 1);
      }

      AuthResult _authResult = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      Get.find<UserController>().user =
          await Database().getUser(_authResult.user.uid);
    } catch (e) {
      Get.snackbar(
        "Error while Signing In",
        e.message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white38,
        duration: Duration(milliseconds: 900),
        overlayBlur: 1,
      );
    }
  }

  void forgotPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      Get.snackbar(
        "Error while Sending reset link",
        e.message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white38,
        overlayBlur: 1,
      );
    }
  }

  void signOut() async {
    try {
      await _auth.signOut();
      Get.find<UserController>().clear();
    } catch (e) {
      Get.snackbar(
        "Error while signing out",
        e.message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white38,
        overlayBlur: 1,
      );
    }
  }
}
