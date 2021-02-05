import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:explore/routing/router_names.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:explore/utils/authentication.dart';
import 'package:explore/routing/router_names.dart';

class RegisterScreen extends StatefulWidget {
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController;
  TextEditingController _passController;
  bool _success;
  String _userMail = '';
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
                  'Giriş Yap',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w500),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, LoginRoute);
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
              height: 800,
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
                          "Logafic'e kayıt ol",
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
                              hintText: ('Geçerli bir mail adresi giriniz.'),
                              labelText: ('*Email')),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
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
                              hintText: ('Geçerli bir şifre giriniz.'),
                              labelText: ('*Şifre')),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
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
                          obscureText: true,
                          decoration: const InputDecoration(
                              icon: Icon(Icons.vpn_key_outlined),
                              hintText: ('Şifreyi tekrar giriniz.'),
                              labelText: ('*Tekrar Şifre')),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: SizedBox(
                        width: 400,
                        child: TextFormField(
                          decoration: const InputDecoration(
                              icon: Icon(Icons.mail_outline),
                              hintText: ('Email adresi .edu uzantılı'),
                              labelText: ('*Okul mail adresi')),
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.all(8),
                        child: SizedBox(
                          width: 400,
                          child: Row(
                            children: [
                              Checkbox(
                                activeColor: Colors.blue,
                                value: false,
                              ),
                              Text('Kullanıcı sözleşmesini kabul ediyorum'),
                            ],
                          ),
                        )),
                    Padding(
                        padding: EdgeInsets.all(8),
                        child: SizedBox(
                          width: 200,
                          height: 50,
                          child: FlatButton(
                            color: Colors.lightGreen[200],
                            child: Text(
                              'Kayıt Ol',
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400),
                            ),
                            onPressed: () {
                              print(_emailController.text);
                              print(_passController.text);
                              try {
                                if (_passController.text != null &&
                                    _emailController.text != null) {
                                  registerWithEmailPassword(
                                      _emailController.text,
                                      _passController.text);
                                  Navigator.pushNamed(context, LoginRoute);
                                } else {
                                  print('Hata var be kardeşim');
                                }
                              } catch (e) {
                                print(e);
                              }
                            },
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
