import 'dart:html';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:explore/screens/home_page.dart';
import 'package:explore/utils/authentication.dart';
import 'package:explore/widgets/auth_dialog.dart';
import 'package:explore/widgets/responsive.dart';
import 'package:flutter/material.dart';

class FirstScreenTopBarContents extends StatefulWidget {
  final double opacity;
  final int fontSize = 16;

  FirstScreenTopBarContents(this.opacity);

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
            fontSize: 30,
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
              onPressed: () {},
            ),
          )
        ],
      ),
      body: Container(
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
                        Row(
                          children: [
                            Icon(
                              Icons.chevron_right,
                              color: Colors.grey[400].withOpacity(0.6),
                            ),
                            Text(
                              ' Karşılaştığın sorunları bizlerle paylaş.',
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.grey[400],
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.chevron_right,
                              color: Colors.grey[400].withOpacity(0.6),
                            ),
                            Text(
                              ' Başkalarının hayatlarına dokun.',
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.grey[400],
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.chevron_right,
                              color: Colors.grey[400].withOpacity(0.6),
                            ),
                            Text(
                              ' Senin gibi düşünen arkadaşlar edin.',
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.grey[400],
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
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
                  child: Image.asset('assets/images/FirstScreenImage.png'),
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
                        Text(
                          'İçerikleri görüntülemek için Giriş yap veya Kayıt ol.',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.grey[400],
                              fontWeight: FontWeight.w400),
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
                              onPressed: () {},
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
                              onPressed: () {},
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
      ),
    );
  }
}
