import 'package:flutter/material.dart';
import 'package:explore/widgets/responsive.dart';
import 'package:explore/widgets/comment_widget.dart';

void main() => runApp(notification());

class notification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Logafic',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF6200EE),
      ),
      home: ListDemo(),
    );
  }
}

class ListDemo extends StatefulWidget {
  @override
  _ListDemoState createState() => _ListDemoState();
}

class _ListDemoState extends State<ListDemo> {
  int groupValue = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Bildirim Sayfası'),
        ),
        body: SizedBox(
          width: 300,
          child: ListView(
            children: [
              for (int count in List.generate(9, (index) => index + 1))
                Column(
                  children: [
                    ListTile(
                      title: Text('Lee-Walsh, Natalie $count'),
                      subtitle: Text('Gönderinizi Puanladı'),
                      leading: Image.network('https://picsum.photos/150'),
                    ),
                    IconButton(
                      icon: Icon(Icons.redo),
                      onPressed: () {},
                    ),
                  ],

                  /*   selected: count == groupValue,
              trailing: Radio(
                value: count,
                groupValue: groupValue,
                onChanged: (value) {
                  setState(() {
                    groupValue = value;
                  });
                },
              ),*/
                ),
            ],
          ),
        ));
  }
}
