import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

CollectionReference likeRef = FirebaseFirestore.instance.collection('posts');
TextEditingController updateContentController = TextEditingController();
Future<void> postUpdataShowDialog(BuildContext context, String postId,
    String content, String createdAt) async {
  updateContentController.text = content;
  return showDialog(
      context: context,
      builder: (_) => new AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            content: Builder(
              builder: (context) {
                // Get available height and width of the build area of this widget. Make a choice depending on the size.
                var height = MediaQuery.of(context).size.height;
                var width = MediaQuery.of(context).size.width;

                return Container(
                    height: height * 0.3,
                    width: width * 0.6,
                    child: Padding(
                      padding: EdgeInsets.all(40),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              'Paylaşım tarihi ve saati',
                              style: TextStyle(fontSize: 20),
                            ),
                            subtitle: Text(
                              createdAt,
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          TextField(
                            onChanged: (value) {},
                            controller: updateContentController,
                            decoration: const InputDecoration(
                              icon: Icon(Icons.message),
                              hintText:
                                  'Bu textbox nasıl kullanman gerektiğini biliyorsun.',
                            ),
                            minLines: 2,
                            maxLines: 4,
                            keyboardType: TextInputType.multiline,
                          ),
                        ],
                      ),
                    ));
              },
            ),
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.all(40),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Vazgeç')),
              ),
              Padding(
                padding: EdgeInsets.only(top: 40, bottom: 40, right: 40),
                child: TextButton(
                    onPressed: () {
                      likeRef.doc(postId).update({
                        'content': updateContentController.text,
                        'created_at': DateTime.now().toString()
                      }).then((value) {
                        Navigator.pop(context);
                        Get.snackbar(
                            'Post güncellendi', DateTime.now().toString());
                      });
                    },
                    child: Text('Güncelle')),
              )
            ],
          ));
}
