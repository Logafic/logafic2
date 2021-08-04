import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logafic/controllers/themeController.dart';
import 'package:logafic/services/messageService.dart';
import 'package:logafic/widgets/responsive.dart';
import 'package:logafic/widgets/showCommentDialogStatusWidget.dart';

// Ekran görüntüleri github adresi üzerinden erişilebilir. 'https://github.com/Logafic/logafic/blob/main/SS/setting_show_dialog.png'

class ShowImageDialogWidget extends StatefulWidget {
  String urlImage;
  ShowImageDialogWidget({Key? key, required this.urlImage}) : super(key: key);

  @override
  _ShowImageDialogWidgetState createState() => _ShowImageDialogWidgetState();
}

class _ShowImageDialogWidgetState extends State<ShowImageDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        content: Builder(builder: (context) {
          var height = MediaQuery.of(context).size.height;
          var width = MediaQuery.of(context).size.width;
          return Container(
              width: width,
              height: height,
              child: Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.cancel),
                  ),
                ),
                body: Image.network(urlImage),
              ));
        }));
  }
}
