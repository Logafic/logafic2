import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:logafic/services/database.dart';
import 'package:logafic/widgets/bottom_bar.dart';
import 'package:logafic/widgets/floating_quick_access_bar.dart';
import 'package:logafic/services/load_data_home_page.dart';
import 'package:logafic/data_model/content_model.dart';

Widget lazyLoadingHomePage(BuildContext context, bool? isLoading,
    TextEditingController postController, List<ContentModel>? data) {
  return LazyLoadScrollView(
      isLoading: isLoading!,
      child: Scrollbar(
        child: ListView(
          children: [
            Center(
              child: Stack(
                children: [
                  Container(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.46,
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset(
                        'assets/images/back_image.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 6 / 10,
                      margin: EdgeInsets.only(top: 25),
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        color: Colors.white60,
                        child: Column(
                          children: [
                            ListTile(
                              leading: Icon(Icons.memory_rounded),
                              title: const Text(
                                'Bizimle bişeyler paylaş',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Form(
                                child: Column(
                                  children: <Widget>[
                                    TextFormField(
                                      controller: postController,
                                      decoration: const InputDecoration(
                                        icon: Icon(Icons.message),
                                        hintText:
                                            'Bu textbox nasıl kullanman gerektiğini biliyorsun.',
                                      ),
                                      minLines: 2,
                                      maxLines: 4,
                                      keyboardType: TextInputType.multiline,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Lütfen boş bırakma null kalmasın.';
                                        }
                                        return null;
                                      },
                                    )
                                  ],
                                ),
                                autovalidateMode: AutovalidateMode.always,
                              ),
                            ),
                            ButtonBar(
                              alignment: MainAxisAlignment.start,
                              children: [
                                ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.black12)),
                                  child: Text(
                                    'Gönder',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                  onPressed: () async {
                                    await Database()
                                        .addPost(postController.text);
                                    postController.clear();
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: isLoading
                  ? CircularProgressIndicator()
                  : FloatingQuickAccessBar(
                      screenSize: MediaQuery.of(context).size),
            ),
            // ListView.builder(
            //   shrinkWrap: true,
            //   physics: NeverScrollableScrollPhysics(),
            //   itemCount: data!.length,
            //   itemBuilder: (context, position) {
            //     if (isLoading && position == data.length - 1) {
            //       return Center(child: CircularProgressIndicator());
            //     } else {
            //       return displayCardItem(context, data[position]);
            //     }
            //   },
            // ),
            BottomBar()
          ],
        ),
      ),
      onEndOfPage: () => loadData(data));
}
