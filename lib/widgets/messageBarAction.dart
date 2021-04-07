import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:explore/routing/router_names.dart';

class MessageBarAction extends StatelessWidget {
  const MessageBarAction({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
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
    );
  }
}