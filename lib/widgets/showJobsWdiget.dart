import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logafic/widgets/responsive.dart';

CollectionReference jobsRef = FirebaseFirestore.instance.collection('jobs');

Future<void> showJobsWidget(BuildContext context, String jobsId) async {
  return showDialog(
      context: context,
      builder: (_) => new AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          content: Builder(builder: (context) {
            var height = MediaQuery.of(context).size.height;
            var width = MediaQuery.of(context).size.width;
            return Container(
                height: height / 2,
                width: ResponsiveWidget.isSmallScreen(context)
                    ? width * 0.9
                    : width * 0.3,
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: FutureBuilder(
                      future: jobsRef.doc(jobsId).get(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text('Birşeyler yanlış gitti'),
                          );
                        }
                        if (snapshot.connectionState == ConnectionState.done) {
                          Map<String, dynamic> data =
                              snapshot.data!.data() as Map<String, dynamic>;
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'İlan ayrıntıları',
                                style: TextStyle(fontSize: 30),
                              ),
                              Divider(),
                              Text(
                                '${data['title']}',
                                style: TextStyle(fontSize: 20),
                              ),
                              Divider(),
                              Text('İlan sahibi :${data['userName']}',
                                  style: TextStyle(fontSize: 20)),
                              Divider(),
                              Text('Şirket adı :${data['companyName']}',
                                  style: TextStyle(fontSize: 20)),
                              Divider(),
                              Text('Kategori :${data['category']}',
                                  style: TextStyle(fontSize: 20)),
                              Divider(),
                              Text('Konum :${data['location']}',
                                  style: TextStyle(fontSize: 20)),
                              Divider(),
                              Text('Açıklaması :${data['explanation']}',
                                  style: TextStyle(fontSize: 20)),
                              Padding(
                                padding: EdgeInsets.all(20),
                                child: ElevatedButton(
                                  child: Text('Başvur'),
                                  onPressed: () {},
                                ),
                              )
                            ],
                          );
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ),
                ));
          })));
}
