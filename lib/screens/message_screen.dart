import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logafic/widgets/background.dart';
import 'package:logafic/routing/router_names.dart';
import 'package:logafic/widgets/messageScreenWidget.dart';
import 'package:logafic/widgets/responsive.dart';
import 'package:logafic/widgets/userMessageScreenWidget.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Stream<QuerySnapshot> _usersMessageStream =
      FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    final headerList = new StreamBuilder(
      stream: _usersMessageStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Text('Bir hatayla karşılaştık..');
        }
        return new ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            return new Padding(
              padding: EdgeInsets.all(8),
              child: new InkWell(
                onTap: () {
                  messageShowDialogWidget(context, data['userName'],
                      data['userProfileImage'], data['userId']);
                },
                child: new Container(
                  decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.circular(10.0),
                      color: Colors.black12,
                      boxShadow: [
                        new BoxShadow(
                            color: Colors.black.withAlpha(20),
                            offset: const Offset(3.0, 10.0),
                            blurRadius: 15.0)
                      ],
                      image: new DecorationImage(
                        image: NetworkImage('${data['userProfileImage']}'),
                      )),
                  width: 200.0,
                  child: new Stack(
                    children: <Widget>[
                      new Align(
                        alignment: Alignment.bottomCenter,
                        child: new Container(
                            decoration: new BoxDecoration(
                                color: Colors.black12,
                                borderRadius: new BorderRadius.only(
                                    bottomLeft: new Radius.circular(10.0),
                                    bottomRight: new Radius.circular(10.0))),
                            height: 30.0,
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Text(
                                  '${data['userName']}',
                                  style: new TextStyle(color: Colors.white),
                                )
                              ],
                            )),
                      )
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
          scrollDirection: Axis.horizontal,
        );
      },
    );

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
          'Mesajlar',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w400,
            letterSpacing: 3,
          ),
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
      body: Center(
        child: new Container(
          width: ResponsiveWidget.isSmallScreen(context)
              ? MediaQuery.of(context).size.width * 0.9
              : MediaQuery.of(context).size.width * 0.7,
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
                          padding: new EdgeInsets.only(left: 14.0),
                          child: new Text(
                            'Kişiler',
                            style: new TextStyle(
                                color: Colors.white70, fontSize: 25),
                          )),
                    ),
                    new Container(
                        height: 300.0, width: _width, child: headerList),
                    Padding(
                      padding: EdgeInsets.all(22),
                      child: new Text(
                        'Son Mesajlar',
                        style: TextStyle(
                            fontSize: ResponsiveWidget.isLargeScreen(context)
                                ? 20
                                : 30),
                      ),
                    ),
                    new Expanded(child: MessageScreenUserMessagesWidget())
                  ],
                ),
              ),
            ],
          ),
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
