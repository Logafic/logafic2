import 'package:flutter/material.dart';

class ProfileSmallWidgetTwo extends StatelessWidget {
  const ProfileSmallWidgetTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new ListTile(
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
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(12.0)),
                    image: new DecorationImage(
                      image: NetworkImage('https://picsum.photos/200/300'),
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
    );
  }
}
