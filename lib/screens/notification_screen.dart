import 'package:flutter/material.dart';
import 'package:explore/widgets/notification_widget.dart';
import 'package:explore/widgets/responsive.dart';
import 'package:explore/routing/router_names.dart';

class NotificationScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return ResponsiveWidget.isLargeScreen(context)
        ? Scaffold(
            appBar: AppBar(
              leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  );
                },
              ),
              title: Text(
                'Bildirimler',
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.grey[100],
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.pushNamed(context, HomeRoute);
                    },
                    child: Text('Anasayfa')),
                Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: InkWell(
                      child: PopupMenuButton(
                    icon: Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                    itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                      PopupMenuItem(
                        child: ListTile(
                          onTap: () {
                            Navigator.pushNamed(context, ProfileRoute);
                          },
                          leading: Icon(Icons.reorder),
                          title: Text('Profilim'),
                        ),
                      ),
                      PopupMenuItem(
                        child: ListTile(
                          onTap: () {
                            Navigator.pushNamed(context, NotificationRoute);
                          },
                          leading: Icon(Icons.notification_important),
                          title: Text('Bildirimler'),
                        ),
                      ),
                      PopupMenuItem(
                        child: ListTile(
                          onTap: () {
                            Navigator.pushNamed(context, MessageRoute);
                          },
                          leading: Icon(Icons.message),
                          title: Text('Mesajlar'),
                        ),
                      ),
                      const PopupMenuDivider(),
                      PopupMenuItem(child: Text('Çıkış Yap')),
                    ],
                  )),
                ),
              ],
            ),
            body: Padding(
              padding: EdgeInsets.only(top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: screenSize.width * 0.4,
                    child: Card(
                      child: ListView(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(18),
                            child: Text(
                              'Lee-Walsh, Natalie bildirimleri',
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                          ),
                          const Divider(),
                          for (int i = 0; i < 3; i++) NotificationWidget(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : PreferredSize(
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  'Bildirimler',
                  style: TextStyle(color: Colors.black),
                ),
                backgroundColor: Colors.white,
                leading: Builder(
                  builder: (BuildContext context) {
                    return IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
                actions: [
                  FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, HomeRoute);
                      },
                      child: Text('Anasayfa')),
                  Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: InkWell(
                        child: PopupMenuButton(
                      icon: Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                        PopupMenuItem(
                          child: ListTile(
                            onTap: () {
                              Navigator.pushNamed(context, ProfileRoute);
                            },
                            leading: Icon(Icons.reorder),
                            title: Text('Profilim'),
                          ),
                        ),
                        PopupMenuItem(
                          child: ListTile(
                            onTap: () {
                              Navigator.pushNamed(context, NotificationRoute);
                            },
                            leading: Icon(Icons.notification_important),
                            title: Text('Bildirimler'),
                          ),
                        ),
                        PopupMenuItem(
                          child: ListTile(
                            onTap: () {
                              Navigator.pushNamed(context, MessageRoute);
                            },
                            leading: Icon(Icons.message),
                            title: Text('Mesajlar'),
                          ),
                        ),
                        const PopupMenuDivider(),
                        PopupMenuItem(child: Text('Çıkış Yap')),
                      ],
                    )),
                  ),
                ],
              ),
              body: ListView(
                children: [
                  ListTile(
                    title: Text('Lee-Walsh, Natalie'),
                    subtitle: Text('1.dk sonra gönderildi.'),
                    leading: Image.network('https://picsum.photos/150'),
                  )
                ],
              ),
            ),
            preferredSize: Size(screenSize.width, 400));
  }
}

/*
return Scaffold(
        appBar:AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Bildirimler',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 500,
                child: Card(
                  child: ListView(
                    children: [
                      for (int i = 0; i < 3; i++) NotificationWidget()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
*/