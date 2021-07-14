import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logafic/controllers/authController.dart';

AuthController authController = AuthController.to;
Future<void> addMessageRefUsers(String receiverUserId) async {
  CollectionReference usersRefs =
      FirebaseFirestore.instance.collection('users');
  usersRefs.doc(receiverUserId).collection('userMessagesList').add({'': ''});
  usersRefs
      .doc(authController.firebaseUser.value!.uid)
      .collection('userMessagesList')
      .add({});
}

Future<void> sendMessage(String messageSentUserId, String message) async {
  CollectionReference sendMessageCollectionRef =
      FirebaseFirestore.instance.collection('messages');
  sendMessageCollectionRef
      .doc(authController.firebaseUser.value!.uid)
      .collection(messageSentUserId)
      .add({
    'messageUserId': authController.firebaseUser.value!.uid,
    'message': message,
    'created_at': DateTime.now()
  });
  sendMessageCollectionRef
      .doc(messageSentUserId)
      .collection(authController.firebaseUser.value!.uid)
      .add({
    'messageUserId': authController.firebaseUser.value!.uid,
    'message': message,
    'created_at': DateTime.now()
  });
}

Future<void> addMessage(
    String messageType, String userName, String userId, String message) async {
  CollectionReference notificationRef = FirebaseFirestore.instance
      .collection('messages')
      .doc('${authController.firebaseUser.value!.uid}')
      .collection(userId);

  notificationRef.add({
    'message': message,
    'messageType': messageType,
    'created_at': DateTime.now().toString()
  });
}
