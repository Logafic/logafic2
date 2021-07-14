import 'package:flutter/material.dart';

class NotificationWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.4,
          child: ListTile(
            title: Text('Lee-Walsh, Natalie'),
            isThreeLine: true,
            subtitle: Text(
                '1 dk önce gerçekleşti.\nLorem ipsum dolor sit amet, consectetur adipiscing elit.\n'),
            leading: Image.network('https://picsum.photos/150'),
          ),
        ),
        IconButton(
          icon: Icon(Icons.reply),
          tooltip: 'Git',
          onPressed: () {},
        ),
        Divider()
      ],
    ));
  }
}
