import 'package:flutter/material.dart';
import 'package:logafic/routing/router.dart';
import 'package:logafic/routing/router_names.dart';
import 'package:logafic/services/navigation_service.dart';
import 'package:logafic/utils/authentication.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;

Future<void> main() async {
  runApp(MyApp());
  await firebase_core.Firebase.initializeApp();
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    //getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LOGAFİC',
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigationService().navigatorKey,
      onGenerateRoute: generateRoute,
      initialRoute: uid == null ? FirstRoute : HomeRoute,
    );
  }
}
