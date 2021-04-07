import 'dart:html';

import 'package:flutter/material.dart';
import 'package:explore/widgets/menubaraction.dart';
import 'package:explore/widgets/comment_widget.dart';
import 'package:explore/routing/router_names.dart';

class StatusScreen extends StatelessWidget {
  final String id;

  StatusScreen({Key key, @required this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
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
            'Gönderi',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w400,
              letterSpacing: 3,
            ),
          ),
          actions: <Widget>[MenuActionBar()],
        ),
        body: Scrollbar(
            child: ListView(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: Card(
                      color: Colors.grey[150],
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [
                          ListTile(
                            leading: Image.network('https://picsum.photos/150'),
                            title: const Text(
                              'Lee-Walsh, Natalie',
                            ),
                            subtitle: Text('1 dk önce yayınlandı.'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin vestibulum ac nisi id placerat. Praesent nec ante et lorem semper venenatis eget id mauris. Aenean auctor efficitur cursus. In vitae pharetra urna. Pellentesque faucibus massa diam. In sit amet mauris suscipit, volutpat tortor id, rutrum risus. Phasellus nec justo urna. Donec vitae lectus dignissim, venenatis ligula ut, scelerisque justo. Nullam auctor blandit hendrerit. Pellentesque vitae feugiat arcu. Duis sit amet tincidunt nulla, eget morbi. '),
                          ),
                          ButtonBar(
                            alignment: MainAxisAlignment.start,
                            children: [
                              FlatButton(
                                textColor: Colors.black,
                                onPressed: () {},
                                child: Text('Yorum Yap'),
                              ),
                              FlatButton(
                                textColor: Colors.blue,
                                onPressed: () {},
                                child: Text('Yorumlar'),
                              ),
                            ],
                          ),
                          Text(
                            'Yorumlar',
                            style: TextStyle(fontSize: 25),
                          ),
                          Divider(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              for (int i = 0; i < 2; i++) CommentWidget()
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        )));
  }
}
