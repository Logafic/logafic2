import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logafic/widgets/messageScreenWidget.dart';

class MessageScreenUserMessagesWidget extends StatelessWidget {
  MessageScreenUserMessagesWidget({Key? key}) : super(key: key);
  final Stream<QuerySnapshot> messaegScreenUserMessagesStream =
      FirebaseFirestore.instance.collection('messages').snapshots();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: messaegScreenUserMessagesStream,
        initialData: Text('Henüz bir mesajınız bulunmamaktadır'),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            Center(child: CircularProgressIndicator());
          }
          return Container(
            child: ListView(children: [
              new Align(
                alignment: Alignment.centerLeft,
                child: new Padding(
                    padding: new EdgeInsets.only(left: 14.0, bottom: 8),
                    child: new Text(
                      'Mesajlar',
                      style: new TextStyle(color: Colors.black, fontSize: 25),
                    )),
              ),
              new ListTile(
                onTap: () {
                  messageShowDialogWidget(context, 'yunus', '', '');
                },
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
                          onPressed: () {
                            messageShowDialogWidget(context, 'yunus', '', '');
                          },
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
          );
        },
      ),
    );
  }
}
