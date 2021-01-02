import 'package:flutter/material.dart';
import 'package:explore/screens/home_page.dart';
import 'package:explore/widgets/first_screen_top_bar.dart';
import 'package:explore/screens/login_screen.dart';
import 'package:explore/screens/status_screen.dart';
import 'package:explore/screens/register_screen.dart';
import 'package:explore/screens/profile_screen.dart';

class RouterPage extends StatelessWidget {
  Widget build(BuildContext context) {
    double _opacity = 0;
    return MaterialApp(routes: {
      '/Anasayfa': (context) => HomePage(),
      '/profil': (context) => ProfileScreen(),
      '/durum': (context) => StatusScreen(),
      '/kayitol': (context) => RegisterScreen(),
      '/girisyap': (context) => LoginScreen(),
      '/': (context) => FirstScreenTopBarContents(_opacity),
    });
  }
}
