import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:logafic/controllers/authController.dart';

import 'package:logafic/data_model/content_model.dart';
import 'package:logafic/routing/router_names.dart';
import 'package:logafic/services/database.dart';
import 'package:logafic/services/notificationService.dart';
import 'package:logafic/widgets/appBarHomePageWidget.dart';
import 'package:logafic/widgets/explore_drawer.dart';
import 'package:logafic/widgets/floating_quick_access_bar.dart';
import 'package:logafic/widgets/responsive.dart';
import 'package:logafic/widgets/top_bar_contents.dart';
import 'package:flutter/material.dart';
import 'package:logafic/widgets/background.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isRank = false;
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('posts')
      .orderBy('created_at', descending: true)
      .snapshots();

  CollectionReference likeRef = FirebaseFirestore.instance.collection('posts');
  AuthController authController = AuthController.to;

  final postController = TextEditingController();
  bool isLoading = false;
  ScrollController? _scrollController;
  double _scrollPosition = 0;
  double _opacity = 0;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController!.addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController!.position.pixels;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;
    _opacity = 1;

    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    final body = new Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: ResponsiveWidget.isSmallScreen(context)
            ? appBarHomePageWidget()
            : PreferredSize(
                preferredSize: Size(screenSize.width, 1000),
                child: TopBarContents(_opacity),
              ),
        drawer: ExploreDrawer(),
        body: LazyLoadScrollView(
            onEndOfPage: () {},
            child: Scrollbar(
              child: ListView(
                children: [
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          child: SizedBox(
                            height: screenSize.height * 0.34,
                            width: screenSize.width,
                            child: Image.asset(
                              'assets/images/back_image.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 6 / 10,
                            margin: EdgeInsets.only(top: 100),
                            child: Card(
                              clipBehavior: Clip.antiAlias,
                              color: Colors.white60,
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: Icon(Icons.memory_rounded),
                                    title: const Text(
                                      'Bizimle bişeyler paylaş',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Form(
                                      child: Column(
                                        children: <Widget>[
                                          TextFormField(
                                            controller: postController,
                                            decoration: const InputDecoration(
                                              icon: Icon(Icons.message),
                                              hintText:
                                                  'Bu textbox nasıl kullanman gerektiğini biliyorsun.',
                                            ),
                                            minLines: 2,
                                            maxLines: 4,
                                            keyboardType:
                                                TextInputType.multiline,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Lütfen boş bırakma null kalmasın.';
                                              }
                                              return null;
                                            },
                                          )
                                        ],
                                      ),
                                      autovalidateMode: AutovalidateMode.always,
                                    ),
                                  ),
                                  ButtonBar(
                                    alignment: MainAxisAlignment.start,
                                    children: [
                                      ElevatedButton(
                                        child: Text(
                                          'Gönder',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                        onPressed: () async {
                                          await Database()
                                              .addPost(postController.text);
                                          postController.clear();
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: FloatingQuickAccessBar(screenSize: screenSize),
                  ),
                  Expanded(
                      child: StreamBuilder(
                          stream: _usersStream,
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasError) {
                              return Center(
                                child: Text('Birşeyler yanlış gitti'),
                              );
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return new ListView(
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              children: snapshot.data.docs
                                  .map<Widget>((DocumentSnapshot document) {
                                Map<String, dynamic> data =
                                    document.data() as Map<String, dynamic>;
                                return new Center(
                                    child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                        child: GestureDetector(
                                          onTap: () {
                                            print(document.id);
                                            Navigator.pushNamed(
                                                context, StatusRoute,
                                                arguments: {'id': document.id});
                                          },
                                          child: Card(
                                            color: Colors.grey[50],
                                            clipBehavior: Clip.antiAlias,
                                            child: Column(
                                              children: [
                                                ListTile(
                                                  leading: Image.network(
                                                      data['userProfile']),
                                                  title: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      TextButton(
                                                        child: Text(
                                                          (data['userName']),
                                                        ),
                                                        onPressed: () {
                                                          Navigator.pushNamed(
                                                              context,
                                                              ProfileRoute,
                                                              arguments: {
                                                                'userId': data[
                                                                    'userId']
                                                              });
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                  subtitle: Text(
                                                      data['created_at']
                                                          .toString()),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(data['content']),
                                                ),
                                                ButtonBar(
                                                  alignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    TextButton(
                                                      onPressed: () {},
                                                      child: Text(
                                                        'Yorum Yap',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black54),
                                                      ),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {},
                                                      child: Text(
                                                        'Yorumlar',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black54),
                                                      ),
                                                    ),
                                                    FutureBuilder(
                                                      future: checkIfDocExists(
                                                          '${document.id}'),
                                                      builder:
                                                          (BuildContext context,
                                                              AsyncSnapshot
                                                                  snapshot) {
                                                        if (snapshot.data ==
                                                            false) {
                                                          return IconButton(
                                                              icon: Icon(
                                                                Icons
                                                                    .star_outline,
                                                                color: Colors
                                                                    .green,
                                                              ),
                                                              onPressed: () {
                                                                likeRef
                                                                    .doc(
                                                                        '${document.id}')
                                                                    .get()
                                                                    .then(
                                                                        (value) {
                                                                  var like =
                                                                      value.get(
                                                                          'like');
                                                                  print(like);
                                                                  likeRef
                                                                      .doc(
                                                                          '${document.id}')
                                                                      .update({
                                                                    'like':
                                                                        like + 1
                                                                  });
                                                                });

                                                                likeRef
                                                                    .doc(
                                                                        '${document.id}')
                                                                    .collection(
                                                                        'likes')
                                                                    .doc(
                                                                        '${authController.firebaseUser.value!.uid}')
                                                                    .set({
                                                                  'like': true
                                                                }).then((value) => addNotification(
                                                                        data[
                                                                            'userProfile'],
                                                                        '${authController.firestoreUser.value!.userName}',
                                                                        data[
                                                                            'userId'],
                                                                        authController
                                                                            .firebaseUser
                                                                            .value!
                                                                            .uid));
                                                              });
                                                        } else {
                                                          return IconButton(
                                                              icon: Icon(
                                                                Icons
                                                                    .star_outline,
                                                                color: Colors
                                                                    .amber,
                                                              ),
                                                              onPressed: () {
                                                                likeRef
                                                                    .doc(
                                                                        '${document.id}')
                                                                    .get()
                                                                    .then(
                                                                        (value) {
                                                                  var like =
                                                                      value.get(
                                                                          'like');
                                                                  print(like);
                                                                  likeRef
                                                                      .doc(
                                                                          '${document.id}')
                                                                      .update({
                                                                    'like':
                                                                        like - 1
                                                                  });
                                                                });
                                                                likeRef
                                                                    .doc(
                                                                        '${document.id}')
                                                                    .collection(
                                                                        'likes')
                                                                    .doc(
                                                                        '${authController.firebaseUser.value!.uid}')
                                                                    .delete();
                                                              });
                                                        }
                                                      },
                                                    ),
                                                    FutureBuilder(
                                                        future: getSize(
                                                            '${document.id}'),
                                                        builder: (BuildContext
                                                                context,
                                                            AsyncSnapshot<int>
                                                                snapshot) {
                                                          if (snapshot
                                                              .hasData) {
                                                            return Text(snapshot
                                                                .data
                                                                .toString());
                                                          }
                                                          return Text('0');
                                                        }),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        )));
                              }).toList(),
                            );
                          })),
                  // BottomBar()
                ],
              ),
            )));
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
