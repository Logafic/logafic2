import 'package:flutter/material.dart';
import 'package:logafic/routing/router.dart';
import 'package:logafic/routing/router_names.dart';
import 'package:logafic/services/navigation_service.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  runApp(MyApp());
  await firebase_core.Firebase.initializeApp();
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool currentUser = false;
  @override
  void initState() {
    //getUserInfo();
    getShared();

    super.initState();
  }

  Future getShared() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getBool('auth') != false) {
      setState(() {
        currentUser = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LOGAFİC',
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigationService().navigatorKey,
      onGenerateRoute: generateRoute,
      initialRoute: currentUser ? FirstRoute : HomeRoute,
    );
  }
}
