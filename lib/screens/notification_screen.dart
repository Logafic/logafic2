import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_widget_cache.dart';
import 'package:logafic/controllers/authController.dart';
import 'package:logafic/routing/router_names.dart';
import 'package:logafic/widgets/background.dart';

// ignore: must_be_immutable
class NotificationScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    AuthController authController = AuthController.to;
    CollectionReference notiRef =
        FirebaseFirestore.instance.collection('notification');
    final Stream<QuerySnapshot> _notificationSteam = FirebaseFirestore.instance
        .collection('notifications')
        .doc('${authController.firebaseUser.value!.uid}')
        .collection('userNotification')
        .snapshots();

    final body = new Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
        title: Text(
          'Bildirimler',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, HomeRoute);
              },
              child: Text(
                'Anasayfa',
                style: TextStyle(color: Colors.white),
              )),
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: InkWell(
                child: PopupMenuButton(
              icon: Icon(
                Icons.person,
                color: Colors.white,
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
      backgroundColor: Colors.transparent,
      body: new Container(
        child: new Stack(
          children: <Widget>[
            new Padding(
              padding: new EdgeInsets.only(top: 10.0),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Align(
                    alignment: Alignment.centerLeft,
                    child: new Padding(
                        padding: new EdgeInsets.only(left: 8.0),
                        child: new Text(
                          'Bildirimler',
                          style: new TextStyle(
                              color: Colors.white70, fontSize: 26),
                        )),
                  ),
                  new Expanded(
                      child: Scrollbar(
                          child: StreamBuilder<QuerySnapshot>(
                    stream: _notificationSteam,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.data == null) {
                        return Center(
                          child: Text(
                            'Henüz bir bildiriminiz bulunmamaktadır.',
                            style: TextStyle(fontSize: 20),
                          ),
                        );
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return new ListView(
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data() as Map<String, dynamic>;
                          return new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: ListTile(
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextButton(
                                        child: Text(
                                          ('${data['userName']} gönderinizi beğendi'),
                                        ),
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, ProfileRoute,
                                              arguments: {
                                                'userId': data['userId']
                                              });
                                        },
                                      ),
                                    ],
                                  ),
                                  isThreeLine: true,
                                  subtitle: Text('${data['created_at']}\n'),
                                  leading:
                                      Image.network('${data['userImage']}'),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete_forever_outlined),
                                tooltip: 'Sil',
                                onPressed: () {
                                  notiRef
                                      .doc(
                                          '${authController.firebaseUser.value!.uid}')
                                      .collection('userNotification')
                                      .doc('${document.id}')
                                      .delete();
                                },
                              ),
                              Divider()
                            ],
                          );
                        }).toList(),
                      );
                    },
                  )))
                ],
              ),
            ),
          ],
        ),
      ),
    );
    return new Container(
      decoration: new BoxDecoration(
        color: Colors.black26,
      ),
      child: new Stack(
        children: <Widget>[
          new CustomPaint(
            size: new Size(_width, _height),
            painter: new Background(),
          ),
          body,
        ],
      ),
    );
  }
}
