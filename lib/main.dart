import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:osvaldo_app/views/admin/login/view.dart';
import 'package:osvaldo_app/views/admin/main/view.dart';
import 'package:osvaldo_app/views/client/home/view.dart';
import 'package:osvaldo_app/views/client/login/view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/login-client',
      getPages: [
        GetPage(name: '/login-client', page: () => LoginClientPage()),
        GetPage(name: '/login-admin', page: () => LoginAdminPage()),
        GetPage(name: '/home-client', page: () => HomeClientPage()),
        GetPage(name: '/home-admin', page: () => HomeAdminPage()),
      ],
    );
  }
}
