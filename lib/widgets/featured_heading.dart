import 'package:explore/widgets/responsive.dart';
import 'package:flutter/material.dart';

List<String> userName = [
  'Stanbrige, Peter',
  'Lee-Walsh, Natalie',
  'Li, Ang',
  'Ithya, Nguta',
  'French, Tamzyn',
  'Simoes, Salome',
  'Virtue, Trevor',
  'Campbell-Gillies,Tarryn',
  'Anderson, Eugenia',
];

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
                              leading:
                                  Image.network('https://picsum.photos/150'),
                              title: const Text(
                                'Lee-Walsh, Natalie',
                              ),
                              subtitle: Text('1 dk önce yayınlandı.'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin vestibulum ac nisi id placerat. Praesent nec ante et lorem semper venenatis eget id mauris. Aenean auctor efficitur cursus. In vitae pharetra urna. Pellentesque faucibus massa diam. In sit amet mauris suscipit, volutpat tortor id, rutrum risus. Phasellus nec justo urna. Donec vitae lectus dignissim, venenatis ligula ut, scelerisque justo. Nullam auctor blandit hendrerit. Pellentesque vitae feugiat arcu. Duis sit amet tincidunt nulla, eget morbi. '),
                            ),
                            ButtonBar(
                              alignment: MainAxisAlignment.start,
                              children: [
                                FlatButton(
                                  textColor: Colors.black,
                                  onPressed: () {},
                                  child: Text('Yorum Yap'),
                                ),
                                FlatButton(
                                  textColor: Colors.blue,
                                  onPressed: () {},
                                  child: Text('Yorumlar'),
                                ),
                                IconButton(
                                    alignment: Alignment.centerRight,
                                    icon: Icon(Icons.star_outline),
                                    tooltip: 'Bunu hak ettin',
                                    onPressed: () {
                                      icon:
                                      Icon(Icons.star);
                                    }),
                                Text('12'),
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
