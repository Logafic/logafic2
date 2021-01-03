import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  final int screenSizeW = 1920;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: [
        SizedBox(
          width: 1500,
          child: ListTile(
            title: Text('Lee-Walsh, Natalie'),
            isThreeLine: true,
            subtitle: Text(
                '1 dk önce gönderildi.\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Proin vestibulum ac nisi id placerat. Praesent nec ante et lorem semper venenatis eget id mauris. Aenean auctor efficitur cursus. In vitae pharetra urna. Pellentesque faucibus massa diam. In sit amet mauris suscipit, volutpat tortor id, rutrum risus. Phasellus nec justo urna. Donec vitae lectus dignissim, venenatis ligula ut, scelerisque justo. Nullam auctor blandit hendrerit.\n'),
            leading: Image.network('https://picsum.photos/150'),
          ),
        ),
        IconButton(
          icon: Icon(Icons.reply),
          tooltip: 'Yanıtla',
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(
            Icons.delete,
          ),
          tooltip: 'Sil',
          onPressed: () {},
        ),
        const Divider(),
      ],
    ));
    /*Row(
      children: [
        Row(
          children: [
            Column(
              children: <Widget>[
                ListTile(
                  title: Text('Lee-Walsh, Natalie'),
                  isThreeLine: true,
                  subtitle: Text(
                      '1 dk önce gönderildi.\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Proin vestibulum ac nisi id placerat. Praesent nec ante et lorem semper venenatis eget id mauris. Aenean auctor efficitur cursus. In vitae pharetra urna. Pellentesque faucibus massa diam. In sit amet mauris suscipit, volutpat tortor id, rutrum risus. Phasellus nec justo urna. Donec vitae lectus dignissim, venenatis ligula ut, scelerisque justo. Nullam auctor blandit hendrerit.\n'),
                  leading: Image.network('https://picsum.photos/150'),
                ),
              ],
            ),
            Column(
              children: [
                IconButton(
                  icon: Icon(Icons.reply),
                  tooltip: 'Yanıtla',
                  onPressed: () {},
                ),
              ],
            ),
            Column(children: [
              IconButton(
                icon: const Icon(
                  Icons.delete,
                ),
                tooltip: 'Sil',
                onPressed: () {},
              )
            ])
          ],
        ),
      ],
    );*/
  }
}
