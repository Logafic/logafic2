import 'package:flutter/material.dart';

class Web19201 extends StatelessWidget {
  Web19201({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Stack(
        children: <Widget>[
          Transform.translate(
            offset: Offset(8.0, -200.0),
            child:
                // Adobe XD layer: 'pexels-instawalli-1…' (shape)
                Container(
              width: 1920.0,
              height: 1280.1,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage(''),
                  fit: BoxFit.fill,
                ),
                border: Border.all(width: 1.0, color: const Color(0xff707070)),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(390.0, 0.0),
            child: Container(
              width: 1075.0,
              height: 1080.0,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                color: const Color(0x12ffffff),
                border: Border.all(width: 1.0, color: const Color(0x12707070)),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(127.0, 540.0),
            child: Text(
              'Karşılaştığın zorlukları bizlerle paylaş',
              style: TextStyle(
                fontFamily: 'Miriam Libre',
                fontSize: 30,
                color: const Color(0xbfffffff),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(127.0, 599.0),
            child: Text(
              'Başkalarının sorunlarına yardımcı ol',
              style: TextStyle(
                fontFamily: 'Miriam Libre',
                fontSize: 30,
                color: const Color(0xbfffffff),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(46.0, 58.0),
            child: Text(
              'LOGAFIC',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 70,
                color: const Color(0x6bffffff),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(127.0, 658.0),
            child: Text(
              'Senin gibi arkadaşlar edin.',
              style: TextStyle(
                fontFamily: 'Miriam Libre',
                fontSize: 30,
                color: const Color(0xbfffffff),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(1465.0, 0.0),
            child: Container(
              width: 455.0,
              height: 1081.0,
              decoration: BoxDecoration(
                color: const Color(0x61000000),
                border: Border.all(width: 1.0, color: const Color(0x61707070)),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(1494.0, 393.0),
            child: Text(
              '   İçerikleri görüntülemek\niçin Giriş yap veya Kayıt ol',
              style: TextStyle(
                fontFamily: 'Miriam Libre',
                fontSize: 30,
                color: const Color(0xffffffff),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(1549.0, 525.0),
            child: Container(
              width: 330.0,
              height: 70.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: const Color(0xb5ffffff),
                border: Border.all(width: 1.0, color: const Color(0xb5707070)),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(1549.0, 623.0),
            child: Container(
              width: 330.0,
              height: 70.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: const Color(0xb0ffffff),
                border: Border.all(width: 1.0, color: const Color(0xb0707070)),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(1658.0, 540.0),
            child: Text(
              'Giriş Yap',
              style: TextStyle(
                fontFamily: 'Noto Serif Armenian',
                fontSize: 30,
                color: const Color(0xff0c0c0c),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(1658.0, 637.0),
            child: Text(
              'Kayıt Ol',
              style: TextStyle(
                fontFamily: 'Noto Serif Armenian',
                fontSize: 30,
                color: const Color(0xff0c0c0c),
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}
