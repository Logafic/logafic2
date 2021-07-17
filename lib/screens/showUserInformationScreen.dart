import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logafic/widgets/responsive.dart';

// ignore: must_be_immutable
class ShowFullUserInformationScreen extends StatelessWidget {
  final String userId;
  ShowFullUserInformationScreen({Key? key, required this.userId})
      : super(key: key);

  CollectionReference user = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        backgroundColor: Colors.white,
        title: Text(
          'Kullanıcının bütün bilgileri..',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.message_outlined,
                  color: Colors.black54,
                )),
          )
        ],
      ),
      body: Scrollbar(
          child: FutureBuilder<DocumentSnapshot>(
        future: user.doc(userId).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Birşeyler yanlış gitti daha sonra tekrar deneyiniz.");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return Text("Kullanıcı bilgilerine ulaşılamıyor");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Center(
              child: Scrollbar(
                  child: ResponsiveWidget.isSmallScreen(context)
                      ? Text('')
                      : Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Card(
                            child: ListView(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(20),
                                  child: SizedBox(
                                    width: 400,
                                    height: 400,
                                    child:
                                        Image.network(data['userProfileImage']),
                                  ),
                                ),
                                textField('Kullanıcı Adı', data['userName']),
                                textField('Email', data['email']),
                                textField('Doğum tarihi', data['birtday']),
                                textField('Şehir', data['city']),
                                textField('Üniversite', data['universty']),
                                textField('Bölüm', data['department']),
                                textField('Cinsiyet', data['gender']),
                                textField('Biyografi', data['biograpfy']),
                                textField('Instagram', data['instagram']),
                                textField('Twitter', data['twitter']),
                                textField('Linkedin', data['linkedin']),
                              ],
                            ),
                          ),
                        )),
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      )),
    );
  }

  Widget textField(String title, String content) {
    return Padding(
      padding: EdgeInsets.only(right: 10, left: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Divider(),
          Text(title, style: TextStyle(fontSize: 25)),
          Text(
            ' $content',
            style: TextStyle(fontSize: 20),
          ),
          Divider(),
        ],
      ),
    );
  }
}
