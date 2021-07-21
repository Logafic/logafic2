import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logafic/controllers/authController.dart';
import 'package:logafic/routing/router_names.dart';
import 'package:logafic/widgets/background.dart';
import 'package:logafic/widgets/responsive.dart';

// ignore: must_be_immutable
class NotificationScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    AuthController authController = AuthController.to;
    CollectionReference notiRef =
        FirebaseFirestore.instance.collection('notifications');
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
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, HomeRoute);
              },
              child: Text(
                'Anasayfa',
                style: TextStyle(color: Colors.white, fontSize: 20),
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
                      Navigator.pushNamed(context, ProfileRoute, arguments: {
                        'userId': authController.firebaseUser.value!.uid
                      });
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
                            style: TextStyle(
                                fontSize:
                                    ResponsiveWidget.isLargeScreen(context)
                                        ? 10
                                        : 20),
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
                              Card(
                                child: Container(
                                  width: ResponsiveWidget.isSmallScreen(context)
                                      ? MediaQuery.of(context).size.width * 0.8
                                      : MediaQuery.of(context).size.width * 0.5,
                                  child: ListTile(
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        data['type'] == 'Like'
                                            ? TextButton(
                                                child: Text(
                                                  ('${data['userName']} gönderinizi beğendi'),
                                                  style:
                                                      TextStyle(fontSize: 17),
                                                ),
                                                onPressed: () {
                                                  Navigator.pushNamed(
                                                      context, ProfileRoute,
                                                      arguments: {
                                                        'userId': data['userId']
                                                      });
                                                },
                                              )
                                            : TextButton(
                                                child: Text(
                                                  ('${data['userName']} gönderinize yorum yaptı.'),
                                                  style:
                                                      TextStyle(fontSize: 17),
                                                ),
                                                onPressed: () {
                                                  Navigator.pushNamed(
                                                      context, StatusRoute,
                                                      arguments: {
                                                        'id': data['userId']
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
                              ),
                              IconButton(
                                icon: Icon(Icons.delete_outline_rounded),
                                tooltip: 'Sil',
                                color: Colors.black54,
                                onPressed: () {
                                  try {
                                    notiRef
                                        .doc(
                                            '${authController.firebaseUser.value!.uid}')
                                        .collection('userNotification')
                                        .doc('${document.id}')
                                        .delete()
                                        .whenComplete(() {
                                      Get.snackbar('Silindi',
                                          'Bildirim başarıyla silindi.',
                                          snackPosition: SnackPosition.BOTTOM,
                                          duration: Duration(seconds: 7),
                                          backgroundColor: Get.theme
                                              .snackBarTheme.backgroundColor,
                                          colorText: Get.theme.snackBarTheme
                                              .actionTextColor);
                                    });
                                  } catch (err) {
                                    print(err);
                                  }
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
