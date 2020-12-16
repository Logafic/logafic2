import 'dart:js_util';

import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'LOGAFIC',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w400,
            letterSpacing: 3,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: FlatButton(
              child: Text(
                'Kayıt Ol',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w500),
              ),
              onPressed: () {},
            ),
          )
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: SizedBox(
          width: 500,
          height: 300,
          child: Card(
            color: Colors.white,
            clipBehavior: Clip.antiAlias,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: SizedBox(
                    child: Text(
                      "Logafic'e giriş yap",
                      style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 23,
                          fontFamily: 'Montserrat'),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: SizedBox(
                    width: 400,
                    child: TextFormField(
                      decoration: const InputDecoration(
                          icon: Icon(Icons.mail),
                          hintText: ('Mail adresi'),
                          labelText: ('Email')),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: SizedBox(
                    width: 400,
                    child: TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                          icon: Icon(Icons.vpn_key),
                          hintText: ('Şifre'),
                          labelText: ('Şifre')),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(8),
                    child: SizedBox(
                      width: 200,
                      height: 50,
                      child: FlatButton(
                        color: Colors.blue[300],
                        child: Text(
                          'Giriş Yap',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                              fontWeight: FontWeight.w400),
                        ),
                        onPressed: () {},
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
