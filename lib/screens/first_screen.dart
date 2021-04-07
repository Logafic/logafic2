import 'package:flutter/material.dart';
import 'package:logafic/routing/router_names.dart';
import 'package:logafic/widgets/responsive.dart';

class FirstScreenTopBarContents extends StatefulWidget {
  final double opacity = 8;
  final int fontSize = 16;

  FirstScreenTopBarContents();

  @override
  _FirstScreenTopBarContentsState createState() =>
      _FirstScreenTopBarContentsState();
}

class _FirstScreenTopBarContentsState extends State<FirstScreenTopBarContents> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.6),
      appBar: new AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'LOGAFIC',
          style: TextStyle(
            color: Colors.black.withOpacity(0.6),
            fontSize: 25,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
            letterSpacing: 3,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: FlatButton(
              child: Text(
                'Giriş Yap',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w500),
              ),
              onPressed: () {
                Navigator.pushNamed(context, LoginRoute);
              },
            ),
          )
        ],
      ),
      body: ResponsiveWidget.isLargeScreen(context) ||
              ResponsiveWidget.isMediumScreen(context)
          ? Container(
              child: Row(
                children: <Widget>[
                  Column(
                    children: [
                      SizedBox(
                        width: screenSize.width * 3 / 10,
                        height: screenSize.height * 9 / 10,
                        child: Card(
                          color: Colors.white,
                          clipBehavior: Clip.antiAlias,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Karşılaştığın sorunları bizlerle paylaş.',
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.grey[400],
                                    fontWeight: FontWeight.w400),
                              ),
                              Padding(padding: EdgeInsets.only(bottom: 8)),
                              Text(
                                'Başkalarının hayatlarına dokun.',
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.grey[400],
                                    fontWeight: FontWeight.w400),
                              ),
                              Padding(padding: EdgeInsets.only(bottom: 8)),
                              Text(
                                'Senin gibi düşünen arkadaşlar edin.',
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.grey[400],
                                    fontWeight: FontWeight.w400),
                              ),
                              Padding(padding: EdgeInsets.only(bottom: 8)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: screenSize.width * 3 / 10,
                        height: screenSize.height * 9 / 10,
                        child:
                            Image.asset('assets/images/FirstScreenImage.png'),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: screenSize.width * 4 / 10,
                        height: screenSize.height * 9 / 10,
                        child: Card(
                          color: Colors.white,
                          clipBehavior: Clip.antiAlias,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text(
                                  'İçerikleri görüntülemek için Giriş yap veya Kayıt ol.',
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.grey[400],
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: 200,
                                  height: 50,
                                  child: FlatButton(
                                    color: Colors.grey[300],
                                    child: Text(
                                      'Giriş Yap',
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    onPressed: () {
                                      Navigator.pushNamed(context, LoginRoute);
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: 200,
                                  height: 50,
                                  child: FlatButton(
                                    color: Colors.blue[300],
                                    child: Text(
                                      'Kayıt Ol',
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, RegisterRoute);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          : Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/FirstScreenImage.png',
                        width: screenSize.width * 6 / 10,
                        height: screenSize.height * 6 / 10,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'İçerikleri görüntülemek için Giriş yap veya Kayıt ol.',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w200),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 200,
                          height: 50,
                          child: FlatButton(
                            color: Colors.blue[300],
                            child: Text(
                              'Kayıt Ol',
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, RegisterRoute);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 200,
                          height: 50,
                          child: FlatButton(
                            color: Colors.grey[300],
                            child: Text(
                              'Giriş Yap',
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, LoginRoute);
                            },
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
    );
  }
}
