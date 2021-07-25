import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logafic/controllers/authController.dart';

AuthController authController = AuthController.to;

Future<void> sendMessage(String messageSentUserId, String profileImage,
    String messageSentUserName, String message) async {
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

  lastMessage(messageSentUserId, profileImage, messageSentUserName, message);
}

Future<void> lastMessage(String messageSentUserId, String profileImage,
    String messageSentUserName, String message) async {
  CollectionReference lastMessageRef = FirebaseFirestore.instance
      .collection('users')
      .doc('${authController.firebaseUser.value!.uid}')
      .collection('lastMessages');
  lastMessageRef.doc(messageSentUserId).set({
    'profileImage': profileImage,
    'messageSentUser': messageSentUserName,
    'sender': authController.firebaseUser.value!.uid,
    'message': message,
    'created_at': DateTime.now().toString()
  }).whenComplete(() => setUnreadMessage(messageSentUserId));
}

Future<void> setReadMessage() async {
  CollectionReference checkUnreadMessageReference =
      FirebaseFirestore.instance.collection('users');

  checkUnreadMessageReference
      .doc(authController.firebaseUser.value!.uid)
      .update({'unreadMessage': false});
}

Future<void> setUnreadMessage(String messageSentUserId) async {
  CollectionReference checkUnreadMessageReference =
      FirebaseFirestore.instance.collection('users');

  checkUnreadMessageReference
      .doc(messageSentUserId)
      .update({'unreadMessage': true});
}
