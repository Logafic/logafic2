import 'package:flutter/material.dart';
import 'package:logafic/routing/router.dart';
import 'package:logafic/routing/router_names.dart';
import 'package:logafic/services/navigation_service.dart';
import 'package:logafic/utils/authentication.dart';

void main() {
  runApp(MyApp());
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
