import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logafic/controllers/authController.dart';
import 'package:logafic/routing/router_names.dart';
import 'package:logafic/widgets/background.dart';
import 'package:logafic/widgets/deletePostProfileScreenWidget.dart';
import 'package:logafic/widgets/profileBarAction.dart';
import 'package:logafic/widgets/responsive.dart';
import 'package:logafic/widgets/profile_widget_small.dart';
import 'package:logafic/widgets/updatePostWidget.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatelessWidget {
  AuthController authController = AuthController.to;
  final String userId;
  ProfileScreen({Key? key, required this.userId}) : super(key: key);
  CollectionReference likeRef = FirebaseFirestore.instance.collection('posts');
  TextEditingController updateContentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    var screenSizeW = MediaQuery.of(context).size.width * 8 / 10;

    final body = new Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return new IconButton(
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
          title: new Text(
            'LOGAFIC',
            style: TextStyle(
              color: Colors.black,
              fontSize: screenSizeW > 400 ? 20 : 15,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w400,
              letterSpacing: 3,
            ),
          ),
          backgroundColor: Colors.transparent,
          actions: <Widget>[ProfileActionBar()],
        ),
        body: FutureBuilder<Map>(
            future: getUser(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting ||
                  snapshot.connectionState == ConnectionState.none) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ResponsiveWidget.isLargeScreen(context) ||
                      ResponsiveWidget.isMediumScreen(context)
                  ? new Container(
                      child: Scrollbar(
                      child: ListView(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(top: 8),
                                  child: SizedBox(
                                    width: 200,
                                    height: 200,
                                    child: Image.network(
                                        snapshot.data['userBackImage'] ??
                                            'https://picsum.photos/600'),
                                  )),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 100),
                                child: Text(
                                  'Gönderiler',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.6),
                                    fontSize: 25,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 3,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 100, right: 100),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: screenSizeW * 3 / 10,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 100, top: 10),
                                          child: Card(
                                            color: Colors.grey,
                                            child: Image.network(snapshot
                                                    .data['userProfileImage'] ??
                                                'https://picsum.photos/600/200'),
                                          ),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 100, top: 10),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(right: 5),
                                                  child: Icon(Icons
                                                      .account_circle_outlined),
                                                ),
                                                new Text(
                                                  snapshot.data['userName'] ??
                                                      'Name',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: screenSizeW > 900
                                                        ? 20
                                                        : 13,
                                                    fontFamily: 'sans',
                                                  ),
                                                ),
                                              ],
                                            )),
                                        Divider(
                                          indent: 8,
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 100, top: 5),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(right: 5),
                                                  child: Icon(Icons
                                                      .location_city_outlined),
                                                ),
                                                Text(
                                                  snapshot.data['city'] ??
                                                      'city',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: screenSizeW > 900
                                                        ? 20
                                                        : 13,
                                                    fontFamily: 'sans',
                                                  ),
                                                ),
                                              ],
                                            )),
                                        Divider(
                                          indent: 8,
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 100, top: 5),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(right: 5),
                                                  child:
                                                      Icon(Icons.book_outlined),
                                                ),
                                                Text(
                                                  snapshot.data['department'] ??
                                                      'department',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: screenSizeW > 900
                                                        ? 20
                                                        : 13,
                                                    fontFamily: 'sans',
                                                  ),
                                                )
                                              ],
                                            )),
                                        new Divider(
                                          indent: 8,
                                        ),
                                        authController
                                                    .firebaseUser.value!.uid ==
                                                userId
                                            ? new Padding(
                                                padding: EdgeInsets.only(
                                                    left: 100, top: 5),
                                                child: new Row(
                                                  children: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.pushNamed(
                                                              context,
                                                              UpdateUserInformationRoute,
                                                              arguments: {
                                                                'userId': userId
                                                              });
                                                        },
                                                        child: Text(
                                                          'Profili Düzenle',
                                                          style: TextStyle(
                                                              color: Colors
                                                                      .lightBlue[
                                                                  100]),
                                                        ))
                                                  ],
                                                ))
                                            : Text('')
                                      ],
                                    ),
                                  ),
                                  Expanded(child: streamPosts(userId))
                                ],
                              ))
                        ],
                      ),
                    ))
                  : Container(
                      child: new ListView(
                        children: [
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      child: Image(
                                          image: NetworkImage(snapshot
                                                  .data['userProfileImage'] ??
                                              'https://picsum.photos/200')),
                                    )),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 8),
                                  child: Text(
                                    snapshot.data['userName'] ??
                                        'Kullanıcı Adı',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: screenSizeW > 400 ? 20 : 12,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 3,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 15),
                                  child: Text(
                                    snapshot.data['department'] ?? 'Bölüm',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: screenSizeW > 400 ? 20 : 12,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 3,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    'Gönderiler',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: screenSizeW > 400 ? 20 : 20,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 3,
                                    ),
                                  ),
                                )
                              ]),
                          streamPosts(userId),
                        ],
                      ),
                    );
            }));
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
          body
        ],
      ),
    );
  }

  Widget streamPosts(String userId) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('posts')
          .where('userId', isEqualTo: userId)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          // return Text(snapshot.data.docs[index]['content']);

          return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                return Center(
                    child: SizedBox(
                        width: ResponsiveWidget.isSmallScreen(context)
                            ? MediaQuery.of(context).size.width * 0.9
                            : MediaQuery.of(context).size.width * 0.7,
                        child: GestureDetector(
                          onTap: () {
                            print(snapshot.data.id);
                            Navigator.pushNamed(context, StatusRoute,
                                arguments: {'id': snapshot.data.id});
                          },
                          child: Card(
                            color: Colors.grey[50],
                            clipBehavior: Clip.antiAlias,
                            child: Column(
                              children: [
                                ListTile(
                                    leading: Image.network(snapshot
                                        .data.docs[index]['userProfile']),
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextButton(
                                          child: Text(
                                            (snapshot.data.docs[index]
                                                ['userName']),
                                          ),
                                          onPressed: () {},
                                        ),
                                      ],
                                    ),
                                    subtitle: Text(snapshot
                                        .data.docs[index]['created_at']
                                        .toString()),
                                    trailing: authController
                                                .firebaseUser.value!.uid ==
                                            userId
                                        ? PopupMenuButton(
                                            icon: Icon(
                                              Icons.more_horiz,
                                              color: Colors.black45,
                                            ),
                                            itemBuilder:
                                                (BuildContext context) =>
                                                    <PopupMenuEntry>[
                                              PopupMenuItem(
                                                  child: ListTile(
                                                      onTap: () {
                                                        postUpdataShowDialog(
                                                            context,
                                                            '${snapshot.data.docs[index].id}',
                                                            '${snapshot.data.docs[index]['content']}',
                                                            '${snapshot.data.docs[index]['created_at']}');
                                                      },
                                                      title: Text('Düzenle'),
                                                      leading:
                                                          Icon(Icons.edit))),
                                              const PopupMenuDivider(),
                                              PopupMenuItem(
                                                  child: ListTile(
                                                      onTap: () {
                                                        showDeletePostProfileScreenWidget(
                                                            context,
                                                            '${snapshot.data.docs[index].id}');
                                                      },
                                                      title: Text('Sil'),
                                                      leading:
                                                          Icon(Icons.delete))),
                                            ],
                                          )
                                        : Text('')),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      snapshot.data.docs[index]['content']),
                                ),
                                ButtonBar(
                                  alignment: MainAxisAlignment.start,
                                  children: [
                                    TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        'Yorum Yap',
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        'Yorumlar',
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                    ),
                                    FutureBuilder(
                                      future: checkIfDocExists(
                                          '${snapshot.data.docs[index].id}'),
                                      builder: (BuildContext context,
                                          AsyncSnapshot snapshot) {
                                        if (snapshot.data == false) {
                                          return IconButton(
                                              icon: Icon(
                                                Icons.star_outline,
                                                color: Colors.green,
                                              ),
                                              onPressed: () {
                                                likeRef
                                                    .doc(
                                                        '${snapshot.data.docs[index].id}')
                                                    .collection('likes')
                                                    .doc(userId)
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
                                                    .doc(
                                                        '${snapshot.data.docs[index].id}')
                                                    .collection('likes')
                                                    .doc(userId)
                                                    .delete();
                                              });
                                        }
                                      },
                                    ),
                                    FutureBuilder(
                                        future: getSize(
                                            '${snapshot.data.docs[index].id}'),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<int> snapshot) {
                                          if (snapshot.hasData) {
                                            return Text(
                                                snapshot.data.toString());
                                          }
                                          return Text('0');
                                        }),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )));
              });
        }
      },
    );
  }

  Future<bool> checkIfDocExists(String docId) async {
    try {
      // Get reference to Firestore collection
      var doc = await likeRef.doc(docId).collection('likes').doc(userId).get();
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

  Future<Map<String, dynamic>> getUser() async {
    final documentId = userId;
    CollectionReference user = FirebaseFirestore.instance.collection('users');
    DocumentSnapshot userSnap = await user.doc(documentId).get();
    Map<String, dynamic> data = userSnap.data() as Map<String, dynamic>;
    return data;
  }
}
