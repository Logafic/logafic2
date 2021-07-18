import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logafic/routing/router_names.dart';
import 'package:logafic/services/messageService.dart';
import 'package:logafic/widgets/showApplyJobsDiaologWidget.dart';
import 'package:logafic/widgets/showJobsWdiget.dart';

class ShowMyJobsPostScreen extends StatefulWidget {
  ShowMyJobsPostScreen({Key? key}) : super(key: key);

  @override
  _ShowMyJobsPostScreenState createState() => _ShowMyJobsPostScreenState();
}

final Stream<QuerySnapshot> _userJobsStreamCreatedAt = FirebaseFirestore
    .instance
    .collection('jobs')
    .where('userId', isEqualTo: '${authController.firebaseUser.value!.uid}')
    .snapshots();

class _ShowMyJobsPostScreenState extends State<ShowMyJobsPostScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'İlanlarını görüntüleyin...',
            style: TextStyle(color: Colors.black45),
          ),
        ),
        body: Scrollbar(
          child: ListView(
            children: [
              Expanded(
                  child: StreamBuilder(
                      stream: _userJobsStreamCreatedAt,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text('Bir şeyler yanlış gitti'),
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
                                                        showJobsApplyWidget(
                                                            context,
                                                            document.id);
                                                      },
                                                      child: Text(
                                                        'Başvuraları görüntüle',
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
        ),
      ),
    );
  }
}