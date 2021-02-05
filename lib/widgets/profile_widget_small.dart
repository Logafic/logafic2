import 'dart:html';

import 'package:flutter/material.dart';

var screenSizeW;

class _ArticleDescription extends StatelessWidget {
  _ArticleDescription({
    Key key,
    this.title,
    this.subtitle,
    this.author,
    this.publishDate,
    this.readDuration,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String author;
  final String publishDate;
  final String readDuration;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '$title',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(padding: EdgeInsets.only(bottom: 2.0)),
              Text(
                '$subtitle',
                maxLines: 30,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                '$author',
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black87,
                ),
              ),
              Text(
                '$publishDate - $readDuration',
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomListItemTwo extends StatelessWidget {
  CustomListItemTwo({
    Key key,
    this.thumbnail,
    this.title,
    this.subtitle,
    this.author,
    this.publishDate,
    this.readDuration,
  }) : super(key: key);

  final Widget thumbnail;
  final String title;
  final String subtitle;
  final String author;
  final String publishDate;
  final String readDuration;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: SizedBox(
        height: screenSizeW,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image(image: NetworkImage('https://picsum.photos/50')),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
                child: _ArticleDescription(
                  title: title,
                  subtitle: subtitle,
                  author: author,
                  publishDate: publishDate,
                  readDuration: readDuration,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ProfileWidgetSmall extends StatelessWidget {
  ProfileWidgetSmall({Key key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    screenSizeW = MediaQuery.of(context).size.height * 7 / 10;
    return CustomListItemTwo(
      thumbnail: Container(
        decoration: const BoxDecoration(color: Colors.pink),
      ),
      title: 'Flutter 1.0 Launch',
      subtitle:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin non turpis a eros hendrerit feugiat. In dictum nibh id magna lobortis blandit. Nulla tincidunt dolor at ipsum fringilla dignissim. Nullam sed sapien gravida, maximus eros et, faucibus velit. Aenean laoreet blandit neque, sed luctus eros porttitor eget. In at nisi velit. Sed cursus orci et semper sodales. Curabitur metus velit, luctus mollis sapien vitae, iaculis maximus erat. Suspendisse diam erat, blandit vel dui quis, tincidunt elementum lacus.'
          'This text should max out at two lines and clip',
      author: 'Dash',
      publishDate: 'Dec 28',
      readDuration: '5 mins',
    );
  }
}
