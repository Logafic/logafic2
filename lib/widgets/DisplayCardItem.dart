import 'package:flutter/material.dart';
import 'package:logafic/data_model/content_model.dart';

Widget displayCardItem(BuildContext context, ContentModel? data) {
  return Container(
      child: GestureDetector(
    onTap: () => {
      Navigator.pushNamed(
        context,
        '/status',
      )
    },
    child: Card(
      color: Colors.grey[50],
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            leading: Image.network(data!.image!),
            title: Text(data.parentName!),
            subtitle: Text(data.createdAt!),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(data.content!),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {},
                child: Text('Yorum Yap'),
              ),
              TextButton(
                onPressed: () {},
                child: Text('Yorumlar'),
              ),
              IconButton(icon: Icon(Icons.star_outline), onPressed: () {}),
              Text(data.id.toString()),
            ],
          )
        ],
      ),
    ),
  ));
}
