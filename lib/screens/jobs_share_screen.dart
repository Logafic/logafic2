import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logafic/controllers/authController.dart';
import 'package:logafic/routing/router_names.dart';
import 'package:logafic/widgets/appBarHomePageWidget.dart';
import 'package:logafic/widgets/background.dart';
import 'package:logafic/widgets/explore_drawer.dart';
import 'package:logafic/widgets/jobs_screen_floating_quick_access_bar_widget.dart';
import 'package:logafic/widgets/responsive.dart';
import 'package:logafic/widgets/showJobsWdiget.dart';
import 'package:logafic/widgets/top_bar_contents.dart';

class JobsShareScreen extends StatefulWidget {
  JobsShareScreen({Key? key}) : super(key: key);

  @override
  _JobSharesScreenState createState() => _JobSharesScreenState();
}

class _JobSharesScreenState extends State<JobsShareScreen> {
  final Stream<QuerySnapshot> _jobsStreamCreatedAt = FirebaseFirestore.instance
      .collection('jobs')
      .where('category', isEqualTo: 'İş ilanı')
      .snapshots();
  final Stream<QuerySnapshot> _jobsStreamRanked = FirebaseFirestore.instance
      .collection('jobs')
      .where('category', isEqualTo: 'Etkinlik ilanı')
      .snapshots();

  AuthController authController = AuthController.to;

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
        body: Scrollbar(
          child: ListView(
            children: [
              Center(
                child: JobsScreenFloatingQuickAccessBar(screenSize: screenSize),
              ),
              Expanded(
                  child: StreamBuilder(
                      stream: authController.isRank == true
                          ? _jobsStreamCreatedAt
                          : _jobsStreamRanked,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
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
                                        MediaQuery.of(context).size.width * 0.7,
                                    child: GestureDetector(
                                      onTap: () {
                                        showJobsWidget(context, document.id);
                                      },
                                      child: Card(
                                          color: Colors.grey[50],
                                          clipBehavior: Clip.antiAlias,
                                          child: Column(
                                            children: [
                                              ListTile(
                                                leading: Image.network(
                                                    data['userProfileImage']),
                                                title: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
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
                                                              'userId':
                                                                  data['userId']
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
                                                  child: Text(
                                                    'İlan başlığı : ${data['title']}',
                                                    style:
                                                        TextStyle(fontSize: 30),
                                                  )),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'İlan veren firma : ${data['companyName']}',
                                                    style:
                                                        TextStyle(fontSize: 25),
                                                  )),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'İlan konumu : ${data['location']}',
                                                    style:
                                                        TextStyle(fontSize: 25),
                                                  )),
                                              ButtonBar(
                                                alignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.all(10),
                                                    child: TextButton(
                                                      onPressed: () {
                                                        showJobsWidget(context,
                                                            document.id);
                                                      },
                                                      child: Text(
                                                        'Görüntüle',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black54),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          )),
                                    )));
                          }).toList(),
                        );
                      })),
              // BottomBar()
            ],
          ),
        ));
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
