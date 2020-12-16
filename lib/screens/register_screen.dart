import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RegisterScreen extends StatefulWidget {
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
      ),
      body: Container(
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
                      decoration: const InputDecoration(
                          icon: Icon(Icons.mail),
                          hintText: ('Geçerli bir mail adresi giriniz.'),
                          labelText: ('*Email')),
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
                          hintText: ('Geçerli bir şifre giriniz.'),
                          labelText: ('*Şifre')),
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
                      obscureText: true,
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
