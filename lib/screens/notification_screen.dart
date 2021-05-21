import 'package:flutter/material.dart';
import 'package:logafic/widgets/notification_widget.dart';
import 'package:logafic/routing/router_names.dart';
import 'package:logafic/widgets/background.dart';

class NotificationScreen extends StatelessWidget {
  List<String> items = [
    "Item 1",
    "Item 2",
    "Item 3",
    "Item 4",
    "Item 5",
    "Item 6",
    "Item 7",
    "Item 8"
  ];
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

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
          FlatButton(
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
                mainAxisAlignment: MainAxisAlignment.start,
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
                    child: ListView(children: [
                      for (int i = 0; i < 20; i++) NotificationWidget()
                    ]),
                  ))
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
