import 'package:logafic/screens/home_page.dart';
import 'package:logafic/utils/authentication.dart';
import 'package:flutter/material.dart';
import 'package:logafic/routing/router_names.dart';

import 'auth_dialog.dart';

class logaficDrawer extends StatefulWidget {
  const logaficDrawer({
    Key key,
  }) : super(key: key);

  @override
  _logaficDrawerState createState() => _logaficDrawerState();
}

class _logaficDrawerState extends State<logaficDrawer> {
  bool _isProcessing = false;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).bottomAppBarColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              userEmail == null
                  ? Container(
                      width: double.maxFinite,
                      child: FlatButton(
                        color: Colors.black,
                        hoverColor: Colors.blueGrey[800],
                        highlightColor: Colors.blueGrey[700],
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AuthDialog(),
                          );
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 15.0,
                            bottom: 15.0,
                          ),
                          child: Text(
                            'Giris Yap',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage:
                              imageUrl != null ? NetworkImage(imageUrl) : null,
                          child: imageUrl == null
                              ? Icon(
                                  Icons.account_circle,
                                  size: 40,
                                )
                              : Container(),
                        ),
                        SizedBox(width: 10),
                        Text(
                          name ?? userEmail,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white70,
                          ),
                        )
                      ],
                    ),
              SizedBox(height: 20),
              userEmail != null
                  ? Container(
                      width: double.maxFinite,
                      child: FlatButton(
                        color: Colors.black,
                        hoverColor: Colors.blueGrey[800],
                        highlightColor: Colors.blueGrey[700],
                        onPressed: _isProcessing
                            ? null
                            : () async {
                                setState(() {
                                  _isProcessing = true;
                                });
                                await signOut().then((result) {
                                  print(result);
                                  Navigator.pushNamed(context, FirstRoute);
                                }).catchError((error) {
                                  print('Çıkış yaparken hata oluştu : $error');
                                });
                                setState(() {
                                  _isProcessing = false;
                                });
                              },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 15.0,
                            bottom: 15.0,
                          ),
                          child: _isProcessing
                              ? CircularProgressIndicator()
                              : Text(
                                  'Çıkış Yap',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                    )
                  : Container(),
              userEmail != null ? SizedBox(height: 20) : Container(),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, NotificationRoute);
                },
                child: Text(
                  'Bildirimler',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Divider(
                  color: Colors.blueGrey[400],
                  thickness: 2,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, MessageRoute);
                },
                child: Text(
                  'Mesajlar',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Divider(
                  color: Colors.blueGrey[400],
                  thickness: 2,
                ),
              ),
              InkWell(
                onTap: () {},
                child: Text(
                  'İletişim',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'Copyright © 2020 | LOGAFIC',
                    style: TextStyle(
                      color: Colors.blueGrey[300],
                      fontSize: 14,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
