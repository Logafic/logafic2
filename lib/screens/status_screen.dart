import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logafic/controllers/authController.dart';
import 'package:logafic/routing/router_names.dart';
import 'package:logafic/widgets/menubaraction.dart';
import 'package:logafic/widgets/responsive.dart';
import 'package:logafic/widgets/showCommentDialogStatusWidget.dart';

// ignore: must_be_immutable
class StatusScreen extends StatelessWidget {
  final String id;
  AuthController authController = AuthController.to;
  CollectionReference posts = FirebaseFirestore.instance.collection('posts');
  StatusScreen({Key? key, required this.id}) : super(key: key);

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
        body: Scrollbar(child: getData));
  }

  Widget get getData {
    return FutureBuilder(
      future: posts.doc(id).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Birşeyler yanlış gidiyor.'),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Center(
            child: SizedBox(
              width: ResponsiveWidget.isSmallScreen(context)
                  ? MediaQuery.of(context).size.width * 0.8
                  : MediaQuery.of(context).size.width * 0.6,
              child: Card(
                  child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: ListTile(
                        leading: Image.network(data['userProfile']),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextButton(
                              child: Text(
                                (data['userName']),
                                style: TextStyle(fontSize: 20),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, ProfileRoute,
                                    arguments: {'userId': data['userId']});
                              },
                            ),
                          ],
                        ),
                        subtitle: Text(
                          data['created_at'],
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: data['urlImage'] == ''
                          ? Text(data['content'])
                          : Column(children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                child: Image.network(data['urlImage']),
                              ),
                              data['content'] != ''
                                  ? Padding(
                                      padding: const EdgeInsets.only(top: 20.0),
                                      child: Text(data['content']),
                                    )
                                  : Text('')
                            ]),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: TextButton(
                            onPressed: () {
                              showCommentPostShareWidget(
                                  context,
                                  id,
                                  data['userId'],
                                  data['content'],
                                  data['urlImage'],
                                  data['userProfile'],
                                  data['userName'],
                                  data['created_at']);
                            },
                            child: Text(
                              'Yorum Yap',
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 15),
                            ),
                          ),
                        ),
                        FutureBuilder(
                          future: checkIfDocExists('$id'),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.data == false) {
                              return IconButton(
                                  icon: Icon(
                                    Icons.star_outline,
                                    color: Colors.green,
                                  ),
                                  onPressed: () {
                                    posts
                                        .doc('$id')
                                        .collection('likes')
                                        .doc(
                                            '${authController.firebaseUser.value!.uid}')
                                        .set({'like': true});
                                  });
                            } else {
                              return IconButton(
                                  icon: Icon(
                                    Icons.star_outline,
                                    color: Colors.amber,
                                  ),
                                  onPressed: () {
                                    posts
                                        .doc('$id')
                                        .collection('likes')
                                        .doc(
                                            '${authController.firebaseUser.value!.uid}')
                                        .delete();
                                  });
                            }
                          },
                        ),
                        FutureBuilder(
                            future: getSize('$id'),
                            builder: (BuildContext context,
                                AsyncSnapshot<int> snapshot) {
                              if (snapshot.hasData) {
                                return Text(snapshot.data.toString());
                              }
                              return Text('0');
                            }),
                      ],
                    ),
                    Text(
                      'Yorumlar',
                      style: TextStyle(fontSize: 20),
                    ),
                    Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('posts')
                            .doc(id)
                            .collection('comment')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.hasError) {
                            Center(
                              child: Text(
                                  'Birşeyler yanlış lütfen daha sonra tekrar deneyiniz.'),
                            );
                          }

                          return new ListView(
                            children: snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                              Map<String, dynamic> data =
                                  document.data() as Map<String, dynamic>;
                              return new Padding(
                                  padding: EdgeInsets.all(10),
                                  child: ListTile(
                                    leading:
                                        Image.network(data['userProfileImage']),
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextButton(
                                          child: Text(
                                            (data['userName']),
                                            style: TextStyle(fontSize: 17),
                                          ),
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, ProfileRoute,
                                                arguments: {
                                                  'userId': data['userId']
                                                });
                                          },
                                        ),
                                        Text(
                                          data['comment'],
                                          style: TextStyle(fontSize: 17),
                                        ),
                                        Divider(),
                                      ],
                                    ),
                                    subtitle: Text(
                                      data['created_at'],
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    trailing: authController
                                                .firebaseUser.value!.uid ==
                                            data['userId']
                                        ? IconButton(
                                            onPressed: () {
                                              posts
                                                  .doc(id)
                                                  .collection('comment')
                                                  .doc(document.id)
                                                  .delete();
                                              print(document.id);
                                            },
                                            icon: Icon(
                                                Icons.delete_forever_outlined))
                                        : null,
                                  ));
                            }).toList(),
                          );
                        },
                      ),
                    )
                  ],
                ),
              )),
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Future<bool> checkIfDocExists(String docId) async {
    try {
      // Get reference to Firestore collection
      var doc = await posts
          .doc(docId)
          .collection('likes')
          .doc('${authController.firebaseUser.value!.uid}')
          .get();
      return doc.exists;
    } catch (e) {
      throw e;
    }
  }

  Future<int> getSize(String documentId) async {
    var size = 0;
    await posts
        .doc(documentId)
        .collection('likes')
        .get()
        .then((value) => size = value.size);
    return size;
  }
}
