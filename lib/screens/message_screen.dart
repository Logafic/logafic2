import 'package:flutter/material.dart';
import 'package:explore/widgets/message_widget.dart';

class MessageScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mesajlar'),
        backgroundColor: Colors.pink[200],
      ),
      body: ListView(
        children: [
          for (int i = 0; i < 3; i++) MessageWidget(),
          const Divider(
            indent: 16,
          ),
        ],
      ),
    );
    /*
        child: Column(
          children: [for (int i = 0; i < 5; i++) MessageWidget()],
        ),*/
  }
}
