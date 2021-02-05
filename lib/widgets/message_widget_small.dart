import 'package:flutter/material.dart';

class MessageWidgetScreenSmall extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: ListTile(
          leading: Image(image: NetworkImage('https://picsum.photos/150')),
          title: Text('Stanbrige, Peter'),
          subtitle: Text('Lorem impuls'),
        ),
      ),
    );
  }
}
