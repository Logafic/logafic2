import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:logafic/widgets/background.dart';
import 'package:logafic/widgets/comment_widget.dart';
import 'package:logafic/widgets/profileBarAction.dart';
import 'package:logafic/widgets/responsive.dart';
import 'package:logafic/widgets/profile_widget_small.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    CollectionReference user = FirebaseFirestore.instance.collection('users');
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    var screenSizeW = MediaQuery.of(context).size.width * 8 / 10;
    final body = new Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return new IconButton(
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
          title: new Text(
            'LOGAFIC',
            style: TextStyle(
              color: Colors.black,
              fontSize: screenSizeW > 400 ? 20 : 15,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w400,
              letterSpacing: 3,
            ),
          ),
          backgroundColor: Colors.transparent,
          actions: <Widget>[ProfileActionBar()],
        ),
        body: FutureBuilder<Map>(
            future: getUser(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting ||
                  snapshot.connectionState == ConnectionState.none) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ResponsiveWidget.isLargeScreen(context) ||
                      ResponsiveWidget.isMediumScreen(context)
                  ? new Container(
                      child: Scrollbar(
                      child: ListView(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 200,
                                      child: Image.network(
                                          snapshot.data['userBackImage']),
                                    )
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
                                          child: Image.network(snapshot
                                              .data['userProfileImage']),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 20, top: 10),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(right: 5),
                                                  child: Icon(Icons
                                                      .account_circle_outlined),
                                                ),
                                                new Text(
                                                  snapshot.data['userName'] ??
                                                      'Name',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: screenSizeW > 900
                                                        ? 20
                                                        : 13,
                                                    fontFamily: 'sans',
                                                  ),
                                                ),
                                              ],
                                            )),
                                        Divider(
                                          indent: 8,
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 20, top: 5),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(right: 5),
                                                  child: Icon(Icons
                                                      .location_city_outlined),
                                                ),
                                                Text(
                                                  snapshot.data['city'] ??
                                                      'city',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: screenSizeW > 900
                                                        ? 20
                                                        : 13,
                                                    fontFamily: 'sans',
                                                  ),
                                                ),
                                              ],
                                            )),
                                        Divider(
                                          indent: 8,
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 20, top: 5),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(right: 5),
                                                  child:
                                                      Icon(Icons.book_outlined),
                                                ),
                                                Text(
                                                  snapshot.data['department'] ??
                                                      'department',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: screenSizeW > 900
                                                        ? 20
                                                        : 13,
                                                    fontFamily: 'sans',
                                                  ),
                                                )
                                              ],
                                            )),
                                        new Divider(
                                          indent: 8,
                                        ),
                                        new Padding(
                                            padding: EdgeInsets.only(
                                                left: 20, top: 5),
                                            child: new Row(
                                              children: [
                                                new FlatButton(
                                                    color: Colors.lightBlue,
                                                    onPressed: () {},
                                                    child: Text(
                                                      'Profili Düzenle',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ))
                                              ],
                                            )),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: screenSizeW * 6 / 10,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        for (int i = 0; i < 3; i++)
                                          CommentWidget()
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ))
                  : Container(
                      child: new ListView(
                        children: [
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Image(
                                      image: NetworkImage(
                                          snapshot.data['userProfileImage'])),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 16),
                                  child: Text(
                                    snapshot.data['userName'] ?? 'name',
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
                          for (int i = 0; i < 2; i++) ProfileSmallWidgetTwo(),
                        ],
                      ),
                    );
            }));
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
          body
        ],
      ),
    );
  }

  @override
  Future<Map> getUser() async {
    final documentId = await getUserId();
    CollectionReference user = FirebaseFirestore.instance.collection('users');
    DocumentSnapshot userSnap = await user.doc(documentId).get();
    Map<String, dynamic> data = userSnap.data();
    return data;
  }

  Future<String> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> userInformaiton = prefs.getStringList('user');
    return userInformaiton[0];
  }
}
