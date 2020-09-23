import 'package:get/get.dart';
import 'package:todo_app/controllers/authcontroller.dart';
import 'package:todo_app/models/notesmodel.dart';
import 'package:todo_app/services/database.dart';

class NotesController extends GetxController {
  Rx<List<NotesModel>> notesList = Rx<List<NotesModel>>();
  List<NotesModel> get notes => notesList.value;

  @override
  void onInit() {
    String uid = Get.find<AuthController>().user.uid;
    notesList.bindStream(Database().notesStream(uid));
  }
}
