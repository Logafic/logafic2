import 'package:flutter/material.dart';
import 'package:explore/widgets/message_widget.dart';

class MessageScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mesajlar'),
        backgroundColor: Colors.pink[200],
      ),
      body: Column(
        children: [MessageWidget()],
        /*
        child: Column(
          children: [for (int i = 0; i < 5; i++) MessageWidget()],
        ),*/
      ),
    );
  }
}
