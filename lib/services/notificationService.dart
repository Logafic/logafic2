import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addNotification(String userImage, String userName, String userId,
    String userIdNoti, String type) async {
  CollectionReference notificationRef =
      FirebaseFirestore.instance.collection('notifications');

  notificationRef.doc('$userId').collection('userNotification').add({
    'userId': userIdNoti,
    'userImage': userImage,
    'type': type,
    'userName': userName,
    'created_at': DateTime.now().toString()
  });
}
