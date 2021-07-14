import 'package:get/get.dart';
import 'package:logafic/controllers/authController.dart';
import 'package:logafic/data_model/post_data_model.dart';
import 'package:logafic/services/database.dart';

class PostController extends GetxController {
  AuthController authController = AuthController.to;
  Rxn<List<PostModel>?> postList = Rxn<List<PostModel>>();

  List<PostModel>? get posts => postList.value;

  @override
  void onInit() {
    String uid = authController.firebaseUser.value!.uid;
    postList.bindStream(Database().postStream(uid));
  }
}
