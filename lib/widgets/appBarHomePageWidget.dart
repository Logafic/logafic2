import 'package:flutter/material.dart';

AppBar appBarHomePageWidget() {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    centerTitle: true,
    title: Text(
      'LOGAFIC',
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w400,
        letterSpacing: 3,
      ),
    ),
  );
}
