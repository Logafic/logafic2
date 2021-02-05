import 'package:flutter/material.dart';
import 'package:explore/widgets/comment_widget.dart';
import 'package:explore/routing/router_names.dart';
import 'package:explore/widgets/responsive.dart';
import 'package:explore/widgets/profile_widget_small.dart';

class ProfileScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    var screenSizeW = MediaQuery.of(context).size.width * 8 / 10;
    return Scaffold(
      appBar: AppBar(
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
        title: Text(
          'Lee-Walsh, Natalie',
          style: TextStyle(
            color: Colors.black,
            fontSize: screenSizeW > 400 ? 20 : 15,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w400,
            letterSpacing: 3,
          ),
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
              icon: const Icon(
                Icons.edit,
                color: Colors.black,
              ),
              tooltip: 'Düzenle',
              onPressed: () {}),
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
                PopupMenuItem(child: Text('Çıkış Yap')),
              ],
            )),
          ),
        ],
      ),
      body: ResponsiveWidget.isLargeScreen(context) ||
              ResponsiveWidget.isMediumScreen(context)
          ? Container(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network('https://picsum.photos/$screenSizeW/300'),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: screenSizeW * 3 / 10,
                        child: Column(
                          children: [
                            Card(
                              color: Colors.grey,
                              child: Image.network('https://picsum.photos/300'),
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 20, top: 10),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 5),
                                      child:
                                          Icon(Icons.account_circle_outlined),
                                    ),
                                    Text(
                                      'Lee-Walsh, Natalie',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: screenSizeW > 900 ? 20 : 13,
                                        fontFamily: 'sans',
                                      ),
                                    ),
                                  ],
                                )),
                            Divider(
                              indent: 8,
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 20, top: 5),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 5),
                                      child: Icon(Icons.location_city_outlined),
                                    ),
                                    Text(
                                      'Fukuoka',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: screenSizeW > 900 ? 20 : 13,
                                        fontFamily: 'sans',
                                      ),
                                    ),
                                  ],
                                )),
                            Divider(
                              indent: 8,
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 20, top: 5),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 5),
                                      child: Icon(Icons.book_outlined),
                                    ),
                                    Text(
                                      'Seinan Gakuin University',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: screenSizeW > 900 ? 20 : 13,
                                        fontFamily: 'sans',
                                      ),
                                    )
                                  ],
                                )),
                            Divider(
                              indent: 8,
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 20, top: 5),
                                child: Row(
                                  children: [
                                    FlatButton(
                                        color: Colors.lightBlue,
                                        onPressed: () {},
                                        child: Text(
                                          'Profili Düzenle',
                                          style: TextStyle(color: Colors.white),
                                        ))
                                  ],
                                )),
                          ],
                        ),
                      ),
                      Container(
                        width: screenSizeW * 6 / 10,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (int i = 0; i < 3; i++) CommentWidget()
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          : Container(
              child: ListView(
                children: [
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Image(
                              image: NetworkImage('https://picsum.photos/150')),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 16),
                          child: Text(
                            'Lee-Walsh, Natalie',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: screenSizeW > 400 ? 20 : 15,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w400,
                              letterSpacing: 3,
                            ),
                          ),
                        )
                      ]),
                  for (int i = 0; i < 2; i++) ProfileWidgetSmall(),
                ],
              ),
            ),
    );
  }
}
