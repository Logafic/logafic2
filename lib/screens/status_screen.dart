import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logafic/controllers/authController.dart';
import 'package:logafic/routing/router_names.dart';
import 'package:logafic/widgets/menubaraction.dart';
import 'package:logafic/widgets/responsive.dart';

// ignore: must_be_immutable
class StatusScreen extends StatelessWidget {
  final String id;
  AuthController authController = AuthController.to;
  CollectionReference likeRef = FirebaseFirestore.instance.collection('posts');
  StatusScreen({Key? key, required this.id}) : super(key: key);
  CollectionReference posts = FirebaseFirestore.instance.collection('posts');

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
                      child: Text(
                        data['content'],
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'Yorum Yap',
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 15),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'Yorumlar',
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
                                    likeRef
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
                                    likeRef
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
      var doc = await likeRef
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
    await likeRef
        .doc(documentId)
        .collection('likes')
        .get()
        .then((value) => size = value.size);
    return size;
  }
}
