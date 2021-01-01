import 'package:flutter/material.dart';
import 'package:explore/widgets/comment_widget.dart';

class ProfileScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    var screenSizeW = MediaQuery.of(context).size.width * 8 / 10;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lee-Walsh, Natalie',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
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
                Icons.more_vert,
                color: Colors.black,
              ),
              tooltip: 'Daha fazla',
              onPressed: () {}),
          IconButton(
              icon: const Icon(
                Icons.notification_important,
                color: Colors.black,
              ),
              tooltip: 'Bildir',
              onPressed: () {}),
        ],
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network('https://picsum.photos/$screenSizeW/300'),
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                                  child: Icon(Icons.account_circle_outlined),
                                ),
                                Text(
                                  'Lee-Walsh, Natalie',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
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
                                    fontSize: 20,
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
                                    fontSize: 20,
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
                    width: screenSizeW * 7 / 10,
                    child: Column(
                      children: [for (int i = 0; i < 3; i++) CommentWidget()],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
