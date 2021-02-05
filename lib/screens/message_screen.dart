import 'dart:html';

import 'package:flutter/material.dart';
import 'package:explore/widgets/message_widget.dart';
import 'package:explore/routing/router_names.dart';
import 'package:explore/widgets/responsive.dart';
import 'package:explore/widgets/message_widget_small.dart';

class MessageScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Mesajlar',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              );
            },
          ),
          actions: [
            FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, HomeRoute);
                },
                child: Text('Anasayfa')),
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
                        Navigator.pushNamed(context, ProfileRoute);
                      },
                      leading: Icon(Icons.reorder),
                      title: Text('Profilim'),
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
                  PopupMenuItem(child: Text('Çıkış Yap')),
                ],
              )),
            ),
          ],
        ),
        body: ResponsiveWidget.isLargeScreen(context) ||
                ResponsiveWidget.isMediumScreen(context)
            ? ListView(
                children: [
                  for (int i = 0; i < 3; i++) MessageWidget(),
                  const Divider(
                    indent: 16,
                  ),
                ],
              )
            : ListView(
                children: <Widget>[
                  for (int i = 0; i < 3; i++) MessageWidgetScreenSmall(),
                ],
              ));
    /*
        child: Column(
          children: [for (int i = 0; i < 5; i++) MessageWidget()],
        ),*/
  }
}
