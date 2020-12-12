import 'package:explore/widgets/responsive.dart';
import 'package:flutter/material.dart';

class FeaturedHeading extends StatelessWidget {
  const FeaturedHeading({
    Key key,
    this.screenSize,
  }) : super(key: key);

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
          top: screenSize.height * 0.02,
          left: screenSize.width / 15,
          right: screenSize.width / 15,
        ),
        child: ResponsiveWidget.isSmallScreen(context)
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [],
              )
            : Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: screenSize.width * 8 / 10,
                      child: Card(
                        color: Colors.grey[50],
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          children: [
                            ListTile(
                              leading: Icon(Icons.download_done_outlined),
                              title: const Text('Card Title'),
                              subtitle: Text('Subtitle created time'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  'Lorem impul deneme metinleri olarak oluşturulmuş özel veri karakterleridir.Açık kaynaklı olarak kullanıcıların kullanımına sunulmuştur.'),
                            ),
                            ButtonBar(
                              alignment: MainAxisAlignment.start,
                              children: [
                                FlatButton(
                                  textColor: Colors.black,
                                  onPressed: () {},
                                  child: Text('Action'),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ));
  }
}
