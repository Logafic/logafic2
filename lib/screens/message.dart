import 'package:flutter/material.dart';
import 'package:explore/widgets/message_widget.dart';

import 'package:explore/widgets/responsive.dart';

class MessageScreen extends StatelessWidget {
  final int screenSizeW = 1920;
  final int screenSizeH = 1080;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Mesajlar'),
          backgroundColor: Colors.pink[300],
        ),
        body: Padding(
            padding: EdgeInsets.only(
              top: screenSizeH * 0.02,
              left: screenSizeW / 15,
              right: screenSizeW / 15,
            ),
            child: ResponsiveWidget.isSmallScreen(context)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [MessageWidget()],
                  )
                : Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MessageScreen(),
                      ],
                    ),
                  )));
  }
}
