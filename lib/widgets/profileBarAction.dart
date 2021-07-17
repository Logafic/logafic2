import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logafic/controllers/authController.dart';
import 'package:logafic/routing/router_names.dart';

class ProfileActionBar extends StatelessWidget {
  final String userProfileId;
  ProfileActionBar({Key? key, required this.userProfileId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController = AuthController.to;
    return Container(
        child: Row(children: [
      IconButton(
          icon: const Icon(
            Icons.message_rounded,
            color: Colors.black,
          ),
          tooltip: 'Message Gönder',
          onPressed: () {}),
      IconButton(
          icon: const Icon(
            Icons.notification_important,
            color: Colors.black,
          ),
          tooltip: 'Bildir',
          onPressed: () {}),
      IconButton(
          icon: const Icon(
            Icons.visibility,
            color: Colors.black,
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
            color: Colors.black,
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
