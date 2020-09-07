import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/usercontroller.dart';
import 'package:todo_app/models/usermodel.dart';
import 'package:todo_app/services/database.dart';

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
        Get.back();
      }
    } catch (e) {
      Get.snackbar(
        "Error while sign Up",
        e.message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white38,
        overlayBlur: 1,
      );
    }
  }

  void login(String email, String password) async {
    try {
      AuthResult _authResult = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      Get.find<UserController>().user =
          await Database().getUser(_authResult.user.uid);
    } catch (e) {
      Get.snackbar(
        "Error while signing in",
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
