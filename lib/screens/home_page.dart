import 'package:explore/data_model/content_model.dart';
import 'package:explore/data_model/model.dart';

import 'package:explore/widgets/bottom_bar.dart';
import 'package:explore/data_model/post_data_model.dart';

import 'package:explore/widgets/explore_drawer.dart';
import 'package:explore/widgets/floating_quick_access_bar.dart';

import 'package:explore/widgets/responsive.dart';
import 'package:explore/widgets/top_bar_contents.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:explore/utils/authentication.dart';

import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

final _formKey = GlobalKey<FormState>();

class _HomePageState extends State<HomePage> {
  String firebaseUserId = '';
  String firebaseUserName = '';

  List<int> bottom = <int>[0];
  String _baseUrl = "http://localhost:3000";
  List<ContentModel> data = [];

  final postController = TextEditingController();
  bool isLoading = false;
  ScrollController _scrollController;
  double _scrollPosition = 0;
  double _opacity = 0;

  @override
  void initState() {
    loadData();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    super.initState();
  }

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;
    _opacity = 1;
    return Scaffold(
        backgroundColor: Colors.white70,
        extendBodyBehindAppBar: true,
        appBar: ResponsiveWidget.isSmallScreen(context)
            ? AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.menu_rounded, color: Colors.black45),
                  onPressed: () {
                    setState(() {
                      bottom.add(bottom.length);
                    });
                  },
                ),
                backgroundColor:
                    Theme.of(context).bottomAppBarColor.withOpacity(_opacity),
                elevation: 0,
                centerTitle: true,
                title: Text(
                  'LOGAFIC',
                  style: TextStyle(
                    color: Colors.blueGrey[100],
                    fontSize: 20,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w400,
                    letterSpacing: 3,
                  ),
                ),
              )
            : PreferredSize(
                preferredSize: Size(screenSize.width, 1000),
                child: TopBarContents(_opacity),
              ),
        drawer: ExploreDrawer(),
        body: LazyLoadScrollView(
            isLoading: isLoading,
            child: Scrollbar(
              child: ListView(
                children: [
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          child: SizedBox(
                            height: screenSize.height * 0.45,
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
                            margin: EdgeInsets.only(top: 80),
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
                                            validator: (value) {
                                              if (value.isEmpty) {
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
                                      OutlineButton(
                                        color: Colors.grey[50],
                                        child: Text(
                                          'Gönder',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
                                        ),
                                        textColor: const Color(000),
                                        onPressed: () async {
                                          PostModel post = new PostModel(
                                              userId: uid,
                                              userName: 'Yunus Emre Arslan',
                                              userSmallImage:
                                                  'https://picsum.photos/200',
                                              content: postController.value.text
                                                  .toString());
                                          print(post.toJson());
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
                    child: isLoading
                        ? CircularProgressIndicator()
                        : FloatingQuickAccessBar(screenSize: screenSize),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (context, position) {
                      if (isLoading && position == data.length - 1) {
                        Center(child: CircularProgressIndicator());
                      } else {
                        return DisplayCardItem(data[position]);
                      }
                    },
                  ),
                  BottomBar()
                ],
              ),
            ),
            onEndOfPage: () => loadData()));
  }

  Future<DataModel> loadData() async {
    setState(() {
      isLoading = true;
    });
    await new Future.delayed(const Duration(seconds: 1));
    final res = await http.get("$_baseUrl/user");
    if (res.statusCode == 200) {
      List<dynamic> dataBody = jsonDecode(res.body);
      data =
          data + dataBody.map((dynamic e) => ContentModel.fromJson(e)).toList();
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget DisplayCardItem(ContentModel data) {
    return Container(
        child: GestureDetector(
      onTap: () => {
        Navigator.pushNamed(
          context,
          '/status',
        )
      },
      child: Card(
        color: Colors.grey[50],
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            ListTile(
              leading: Image.network(data.image),
              title: Text(data.parentName),
              subtitle: Text(data.createdAt),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(data.content),
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
                IconButton(icon: Icon(Icons.star_outline), onPressed: () {}),
                Text(data.id.toString()),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
