import 'package:flutter/material.dart';
import 'package:logafic/routing/router_names.dart';
import 'package:logafic/widgets/responsive.dart';
import 'package:logafic/widgets/appBarSingleAction.dart';
import 'package:logafic/widgets/firstSccreenColumnFirst.dart';
import 'package:logafic/widgets/firstScreenColumnThird.dart';
import 'package:logafic/widgets/smallFirstScreen.dart';

import 'package:logafic/widgets/firstScreenColumnSecond.dart';

class FirstScreenTopBarContents extends StatefulWidget {
  final double opacity = 8;
  final int fontSize = 16;
  @override
  _FirstScreenTopBarContentsState createState() =>
      _FirstScreenTopBarContentsState();
}

class _FirstScreenTopBarContentsState extends State<FirstScreenTopBarContents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white.withOpacity(0.6),
        appBar: myAppBar(context, 'LOGAFIC', 'Giriş Yap', LoginRoute),
        body: ResponsiveWidget.isLargeScreen(context) ||
                ResponsiveWidget.isMediumScreen(context)
            ? Row(children: <Widget>[
                firstSccreenColumnFirst(context),
                firstSccreenColumnSecond(context),
                firstScreenColumnThird(context),
              ])
            : smallScreenFirstScreen(context));
  }
}
