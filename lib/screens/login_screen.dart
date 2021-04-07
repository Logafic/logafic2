import 'dart:html';
import 'dart:js_util';

import 'package:explore/routing/router_names.dart';
import 'package:toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:explore/utils/authentication.dart';

class LoginScreen extends StatefulWidget {
  _LoginScreenState createState() => _LoginScreenState();
}

Future<String> success;

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController;
  TextEditingController _passController;
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passController = TextEditingController();
  }

  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  void showToast(String msg, int duration, {int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }

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
                onPressed: () {
                  Navigator.pushNamed(context, RegisterRoute);
                },
              ),
            )
          ],
        ),
        body: Form(
          key: _formKey,
          child: Container(
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
                          controller: _emailController,
                          decoration: const InputDecoration(
                              icon: Icon(Icons.mail),
                              hintText: ('Mail adresi'),
                              labelText: ('Email')),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Lütfen geçerli bir şifreyi giriniz.';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: SizedBox(
                        width: 400,
                        child: TextFormField(
                          controller: _passController,
                          obscureText: true,
                          decoration: const InputDecoration(
                              icon: Icon(Icons.vpn_key),
                              hintText: ('Şifre'),
                              labelText: ('Şifre')),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Lütfen geçerli bir şifreyi giriniz.';
                            }
                            return null;
                          },
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
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  try {
                                    signInWithEmailPassword(
                                            _emailController.text,
                                            _passController.text)
                                        .then((value) {
                                      print(value);
                                      Navigator.pushNamed(context, HomeRoute);
                                      showToast('Giriş Yapıldı', 1);
                                    });
                                  } catch (e) {
                                    showToast(e.toString(), 3);
                                  }
                                }
                              }),
                        ))
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
