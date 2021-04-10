import 'package:flutter/material.dart';
import 'package:logafic/widgets/background.dart';
import 'package:logafic/routing/router_names.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> items = [
    "Yunus Emre Arslan",
    "Melahat Büşra Ekren",
    "Yunus Emre Arslan",
    "Melahat Büşra Ekren",
    "Yunus Emre Arslan",
    "Melahat Büşra Ekren",
    "Yunus Emre Arslan",
    "Melahat Büşra Ekren",
    "Yunus Emre Arslan",
    "Melahat Büşra Ekren",
    "Yunus Emre Arslan",
    "Melahat Büşra Ekren",
    "Yunus Emre Arslan",
    "Melahat Büşra Ekren",
  ];

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    final headerList = new ListView.builder(
      itemBuilder: (context, index) {
        EdgeInsets padding = index == 0
            ? const EdgeInsets.only(
                left: 20.0, right: 10.0, top: 4.0, bottom: 30.0)
            : const EdgeInsets.only(
                left: 10.0, right: 10.0, top: 4.0, bottom: 30.0);

        return new Padding(
          padding: padding,
          child: new InkWell(
            onTap: () {
              print('Card Seçildi..');
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
                    image: NetworkImage('https://picsum.photos/200/300'),
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
                              '${items[index % items.length]}',
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
      },
      scrollDirection: Axis.horizontal,
      itemCount: items.length,
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
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w400,
            letterSpacing: 3,
          ),
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
                        padding: new EdgeInsets.only(left: 14.0),
                        child: new Text(
                          'Kişiler',
                          style: new TextStyle(
                              color: Colors.white70, fontSize: 25),
                        )),
                  ),
                  new Container(
                      height: 300.0, width: _width, child: headerList),
                  new Expanded(
                    child: ListView(children: [
                      new Align(
                        alignment: Alignment.centerLeft,
                        child: new Padding(
                            padding: new EdgeInsets.only(left: 14.0, bottom: 8),
                            child: new Text(
                              'Mesajlar',
                              style: new TextStyle(
                                  color: Colors.black, fontSize: 25),
                            )),
                      ),
                      new ListTile(
                        title: new Column(
                          children: <Widget>[
                            new Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Container(
                                  height: 72.0,
                                  width: 72.0,
                                  decoration: new BoxDecoration(
                                      color: Colors.black12,
                                      boxShadow: [
                                        new BoxShadow(
                                            color: Colors.black.withAlpha(70),
                                            offset: const Offset(2.0, 2.0),
                                            blurRadius: 2.0)
                                      ],
                                      borderRadius: new BorderRadius.all(
                                          new Radius.circular(12.0)),
                                      image: new DecorationImage(
                                        image: NetworkImage(
                                            'https://picsum.photos/200/300'),
                                      )),
                                ),
                                new SizedBox(
                                  width: 10.0,
                                ),
                                new Expanded(
                                    child: new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    new Text(
                                      'My item header',
                                      style: new TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    new Text(
                                      'Item Subheader goes here\nLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry',
                                      style: new TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.normal),
                                    )
                                  ],
                                )),
                                new IconButton(
                                  icon: Icon(Icons.reply),
                                  tooltip: 'Yanıtla',
                                  onPressed: () {},
                                ),
                                new IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                  ),
                                  tooltip: 'Sil',
                                  onPressed: () {},
                                ),
                              ],
                            ),
                            new Divider(),
                          ],
                        ),
                      )
                    ]),
                  )
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
