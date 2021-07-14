import 'package:flutter/material.dart';

Widget firstSccreenColumnSecond(BuildContext context) {
  return Column(
    children: [
      SizedBox(
        width: MediaQuery.of(context).size.width * 3 / 10,
        height: MediaQuery.of(context).size.height * 9 / 10,
        child: Image.asset('assets/images/FirstScreenImage.png'),
      )
    ],
  );
}
