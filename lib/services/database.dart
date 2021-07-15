import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:logafic/controllers/authController.dart';
import 'package:logafic/data_model/post_data_model.dart';

class Database {
  AuthController authController = AuthController.to;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Future<void> addPost(
    String content,
  ) async {
    try {
      if (authController.firebaseUser.value!.uid.isNotEmpty) {
        await _firebaseFirestore.collection('posts').add({
          'created_at': DateTime.now().toString(),
          'userId': authController.firebaseUser.value!.uid,
          'userName': authController.firestoreUser.value!.userName,
          'userProfile': authController.firestoreUser.value!.userProfileImage,
          'content': content,
          'like': 0
        }).then((value) async {
          _firebaseFirestore
              .collection('users')
              .doc('${authController.firebaseUser.value!.uid}')
              .collection('userPosts')
              .add({
            'created_at': DateTime.now().toString(),
            'postId': value.id
          });
          _firebaseFirestore
              .collection('posts')
              .doc(value.id)
              .collection('likes')
              .add({'created_at': DateTime.now().toString()});
          Get.snackbar('Post gönderildi', value.id);
        }).catchError((err) {
          Get.snackbar('Hata', err.toString());
        });
      }
    } on FirebaseException catch (err) {
      print(err);
    }
  }

  Stream<List<PostModel>> postStream(String uid) {
    return _firebaseFirestore
        .collection('posts')
        .orderBy('created_at')
        .snapshots()
        .map((event) {
      List<PostModel> retVal = [];
      event.docs.forEach((element) {
        retVal.add(PostModel.fromJson(element.data()));
      });
      return retVal;
    });
  }
}
