import 'dart:html';

import 'package:flutter/material.dart';
import 'package:logafic/widgets/comment_widget.dart';
import 'package:logafic/widgets/profileBarAction.dart';
import 'package:logafic/widgets/responsive.dart';
import 'package:logafic/widgets/profile_widget_small.dart';

import 'package:logafic/widgets/background.dart';

class ProfileScreen extends StatelessWidget {
  Widget build(BuildContext context) {
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
        backgroundColor: Colors.transparent,
        actions: <Widget>[ProfileActionBar()],
      ),
      body: ResponsiveWidget.isLargeScreen(context) ||
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
                            Image.network(
                                'https://picsum.photos/$screenSizeW/300'),
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
                                  child: Image.network(
                                      'https://picsum.photos/300'),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(left: 20, top: 10),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 5),
                                          child: Icon(
                                              Icons.account_circle_outlined),
                                        ),
                                        Text(
                                          'Lee-Walsh, Natalie',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize:
                                                screenSizeW > 900 ? 20 : 13,
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
                                          child: Icon(
                                              Icons.location_city_outlined),
                                        ),
                                        Text(
                                          'Fukuoka',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize:
                                                screenSizeW > 900 ? 20 : 13,
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
                                            fontSize:
                                                screenSizeW > 900 ? 20 : 13,
                                            fontFamily: 'sans',
                                          ),
                                        )
                                      ],
                                    )),
                                new Divider(
                                  indent: 8,
                                ),
                                new Padding(
                                    padding: EdgeInsets.only(left: 20, top: 5),
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
                  for (int i = 0; i < 2; i++) ProfileSmallWidgetTwo(),
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
          body
        ],
      ),
    );
  }
}
