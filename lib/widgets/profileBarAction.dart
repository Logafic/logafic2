import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logafic/controllers/authController.dart';
import 'package:logafic/routing/router_names.dart';
import 'package:logafic/widgets/showAddedActivityDialogWidget.dart';
import 'package:logafic/widgets/showAddedJobsDialogWidget.dart';
import 'package:logafic/widgets/showReportProfileScreen.dart';

// ProfileScreen menü bar

// ignore: must_be_immutable
class ProfileActionBar extends StatelessWidget {
  final String userProfileId;

  ProfileActionBar({
    Key? key,
    required this.userProfileId,
  }) : super(key: key);
  CollectionReference isAdminRef =
      FirebaseFirestore.instance.collection('Admin');
  bool isAdmin = false;

  @override
  Widget build(BuildContext context) {
    AuthController authController = AuthController.to;
    return Container(
        child: Row(children: [
      authController.firestoreUser.value!.isAdmin == true &&
              authController.firebaseUser.value!.uid == userProfileId
          ? IconButton(
              icon: const Icon(
                Icons.add_business_outlined,
                color: Colors.black54,
              ),
              tooltip: 'İş ilanı ver',
              onPressed: () {
                showAddedJobsDialogWidget(context);
              })
          : Text(''),
      authController.firestoreUser.value!.isAdmin == true &&
              authController.firebaseUser.value!.uid == userProfileId
          ? IconButton(
              icon: const Icon(
                Icons.local_activity_outlined,
                color: Colors.black54,
              ),
              tooltip: 'Etkinlik oluştur',
              onPressed: () {
                showAddedActivityDialogWidget(context);
              })
          : Text(''),
      IconButton(
          icon: const Icon(
            Icons.notification_important,
            color: Colors.black54,
          ),
          tooltip: 'Kullanıcıyı Bildir',
          onPressed: () {
            showDialog(
                context: context,
                builder: (_) {
                  return ShowReportProfileScreenWidget();
                });
          }),
      IconButton(
          icon: const Icon(
            Icons.visibility,
            color: Colors.black54,
          ),
          tooltip: 'Görüntüle',
          onPressed: () {
            Navigator.pushNamed(context, FullProfileRoute,
                arguments: {'userId': userProfileId});
          }),
      Padding(
        padding: EdgeInsets.only(right: 16),
        child: InkWell(
            child: PopupMenuButton(
          icon: Icon(
            Icons.person,
            color: Colors.black54,
          ),
          itemBuilder: (BuildContext context) => <PopupMenuEntry>[
            PopupMenuItem(
              child: ListTile(
                onTap: () {
                  Navigator.pushNamed(context, HomeRoute);
                },
                leading: Icon(Icons.reorder),
                title: Text('Anasayfa'),
              ),
            ),
            PopupMenuItem(
              child: ListTile(
                onTap: () {
                  Navigator.pushNamed(context, NotificationRoute);
                },
                leading: Icon(Icons.notification_important),
                title: Text('Bildirimler'),
              ),
            ),
            PopupMenuItem(
              child: ListTile(
                onTap: () {
                  Navigator.pushNamed(context, MessageRoute);
                },
                leading: Icon(Icons.message),
                title: Text('Mesajlar'),
              ),
            ),
            authController.firestoreUser.value!.isAdmin == true
                ? PopupMenuItem(
                    child: ListTile(
                      onTap: () {},
                      leading: Icon(Icons.message),
                      title: Text('İlanlarım'),
                    ),
                  )
                : PopupMenuItem(
                    child: ListTile(
                      onTap: () {},
                      title: Text(''),
                    ),
                  ),
            const PopupMenuDivider(),
            PopupMenuItem(
              child: ListTile(
                onTap: () async {
                  await authController
                      .signOut()
                      .whenComplete(() => Get.offAllNamed(FirstRoute));
                },
                title: Text('Çıkış Yap'),
              ),
            ),
          ],
        )),
      ),
    ]));
  }
}
