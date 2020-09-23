import 'package:get/get.dart';
import 'package:todo_app/controllers/authcontroller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() async {
    Get.put<AuthController>(AuthController(), permanent: true);
    // Get.put<UserController>(UserController(), permanent: true);
  }
}
