import 'dart:html';

import 'package:flutter/material.dart';
import 'package:logafic/widgets/message_widget.dart';
import 'package:logafic/routing/router_names.dart';
import 'package:logafic/widgets/responsive.dart';
import 'package:logafic/widgets/message_widget_small.dart';
import 'package:logafic/widgets/messageBarAction.dart';

class MessageScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Mesajlar',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
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
          actions: [MessageBarAction()],
        ),
        body: ResponsiveWidget.isLargeScreen(context) ||
                ResponsiveWidget.isMediumScreen(context)
            ? Scrollbar(
                child: ListView(
                children: [
                  for (int i = 0; i < 3; i++) MessageWidget(),
                  const Divider(
                    indent: 16,
                  ),
                ],
              ))
            : ListView(
                children: <Widget>[
                  for (int i = 0; i < 3; i++) MessageWidgetScreenSmall(),
                ],
              ));
  }
}
