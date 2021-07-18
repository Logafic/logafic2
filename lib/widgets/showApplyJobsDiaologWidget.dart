import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logafic/widgets/responsive.dart';

Future<void> showJobsApplyWidget(BuildContext context, String jobsId) async {
  final Stream<QuerySnapshot> _applicationsStream = FirebaseFirestore.instance
      .collection('jobs')
      .doc(jobsId)
      .collection('applications')
      .snapshots();
  return showDialog(
      context: context,
      builder: (_) => new AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          content: Builder(builder: (context) {
            var height = MediaQuery.of(context).size.height;
            var width = MediaQuery.of(context).size.width;
            return Container(
              height: height,
              width: ResponsiveWidget.isSmallScreen(context)
                  ? width * 0.9
                  : width * 0.3,
              child: Card(
                  child: Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                stream: _applicationsStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Bir şeyler yanlış gitti');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return new ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                      return new ListTile(
                        title: new Text(data['userName']),
                      );
                    }).toList(),
                  );
                },
              ))),
            );
          })));
}
