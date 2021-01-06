import 'package:flutter/material.dart';
<<<<<<< Updated upstream
import 'package:explore/widgets/message_widget.dart';
=======
import 'package:explore/widgets/responsive.dart';
import 'package:explore/widgets/comment_widget.dart';
void main() => runApp(message());

class message extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Logafic',
      debugShowCheckedModeBanner: false,
      home: ListDemo(),
      
     
    );
  }
}
>>>>>>> Stashed changes

import 'package:explore/widgets/responsive.dart';

class MessageScreen extends StatelessWidget {
  final int screenSizeW = 1920;
  final int screenSizeH = 1080;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< Updated upstream
        appBar: AppBar(
          title: Text('Mesajlar'),
          backgroundColor: Colors.pink[300],
=======
      appBar: AppBar(
        title: Text('Mesajlar'),
        backgroundColor: Colors.pink[300],
      ),
      body: Container(
      child: Row(
          
          children: [
                Column(
                  children: [ListTile(
                    title: Text('Lee-Walsh, Natalie'),
               
                    isThreeLine: true,
                  
                    subtitle: Text('1 dk önce gönderildi.\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Proin vestibulum ac nisi id placerat. Praesent nec ante et lorem semper venenatis eget id mauris. Aenean auctor efficitur cursus. In vitae pharetra urna. Pellentesque faucibus massa diam. In sit amet mauris suscipit, volutpat tortor id, rutrum risus. Phasellus nec justo urna. Donec vitae lectus dignissim, venenatis ligula ut, scelerisque justo. Nullam auctor blandit hendrerit.\n'),
                
                  leading: Image.network(
                                          'https://picsum.photos/150'),
              

            /*    selected: countToValue[count] ?? false,
                trailing: Checkbox(
                  value: countToValue[count] ?? false,
                  onChanged: (bool value) {
                    setState(() {
                      countToValue[count] = value;
                    });
                  },
                  activeColor: shrineBrown900,
                ),*/
                  ),
                ],
              ),
              Column(children: [IconButton(icon:Icon(Icons.reply),tooltip:'Yanıtla',onPressed: (){},),],),
              Column(children:[IconButton(icon: const Icon(Icons.delete,), tooltip: 'Sil', onPressed: () {},)])
          ],
>>>>>>> Stashed changes
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
