import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:topshot_scan/main_bindings.dart';
import 'package:topshot_scan/main_controller.dart';
import 'package:topshot_scan/modules/Maintenance/maintenance.dart';
import 'package:topshot_scan/pages/homepage/homepage.dart';
import 'package:topshot_scan/pages/homepage/homepage_bindings.dart';
import 'package:topshot_scan/routes/pages.dart';
import 'package:topshot_scan/theme/theme.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:get/get.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MainAppBinding().dependencies();
  HomePageBinding().dependencies();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MainAppController mc = Get.find<MainAppController>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: MainThemeData,
      home: Obx(() {
        return mc.down.isTrue ? Maintenance() : HomePage();
      }),
      initialBinding: HomePageBinding(),
      getPages: Pages.pages,
    );
  }
}
