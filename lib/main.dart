import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logafic/routing/router.dart';
import 'package:logafic/routing/router_names.dart';
import 'package:logafic/services/navigation_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'controllers/authController.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  Get.put<AuthController>(AuthController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'LOGAFIC',
      debugShowCheckedModeBanner: false,
      initialRoute: FirstRoute,
      navigatorKey: NavigationService().navigatorKey,
      onGenerateRoute: generateRoute,
    );
  }
}
