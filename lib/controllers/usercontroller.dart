import 'package:get/state_manager.dart';
import 'package:todo_app/models/usermodel.dart';

class UserController extends GetxController {
  Rx<UserModel> _userModel = UserModel().obs;

  UserModel get user => _userModel.value;

  set user(UserModel value) => this._userModel.value = value;

  void clear() {
    _userModel.value = UserModel();
  }
}
