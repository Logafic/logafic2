import 'package:explore/screens/login_screen.dart';
import 'package:explore/screens/register_screen.dart';
import 'package:explore/widgets/web_scrollbar.dart';
import 'package:explore/widgets/bottom_bar.dart';
import 'package:explore/widgets/destination_heading.dart';
import 'package:explore/widgets/explore_drawer.dart';
import 'package:explore/widgets/featured_heading.dart';
import 'package:explore/widgets/floating_quick_access_bar.dart';
import 'package:explore/widgets/first_screen_top_bar.dart';
import 'package:explore/widgets/responsive.dart';
import 'package:explore/widgets/top_bar_contents.dart';
import 'package:explore/screens/status_screen.dart';
import 'package:explore/screens/profile_screen.dart';

import 'package:flutter/material.dart';

ScrollController _scrollController;
double _scrollPosition = 0;
double _opacity = 0;

class HomePage extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => HomePage(),
        '/profil': (context) => ProfileScreen(),
        '/durum': (context) => StatusScreen(),
        '/girisyap': (context) => LoginScreen(),
        '/kayitol': (context) => RegisterScreen()
      },
    );
  }

  _HomePageState createState() => _HomePageState();
}

final _formKey = GlobalKey<FormState>();

class _FirstScreenState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      extendBodyBehindAppBar: true,
      appBar: ResponsiveWidget.isSmallScreen(context)
          ? AppBar(
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
              child: FirstScreenTopBarContents(),
            ),
    );
  }
}

class _HomePageState extends State<HomePage> {
  ScrollController _scrollController;
  double _scrollPosition = 0;
  double _opacity = 0;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      extendBodyBehindAppBar: true,
      appBar: ResponsiveWidget.isSmallScreen(context)
          ? AppBar(
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
      body: WebScrollbar(
        color: Colors.blueGrey,
        backgroundColor: Colors.blueGrey.withOpacity(0.3),
        width: 10,
        heightFraction: 0.3,
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: ClampingScrollPhysics(),
          child: Column(
            children: [
              Stack(
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
                    child: Column(
                      children: [
                        Container(
                          width: screenSize.width * 6 / 10,
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
                                    key: _formKey,
                                    child: Column(
                                      children: <Widget>[
                                        TextFormField(
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
                                            color: Colors.black, fontSize: 16),
                                      ),
                                      textColor: const Color(000),
                                      onPressed: () {},
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      FloatingQuickAccessBar(screenSize: screenSize),
                      Container(
                        child: Column(
                          children: [
                            for (int i = 0; i < 5; i++)
                              FeaturedHeadingStatu(
                                screenSize: screenSize,
                              )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
              // SizedBox(height: screenSize.height / 8),
              DestinationHeading(screenSize: screenSize),
              SizedBox(height: screenSize.height / 10),
              BottomBar(),
            ],
          ),
        ),
      ),
    );
  }
}
