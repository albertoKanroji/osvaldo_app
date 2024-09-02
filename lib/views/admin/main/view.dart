import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeAdminPage extends StatelessWidget {
  final storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Admin'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              storage.erase();
              Get.offAllNamed('/login-admin');
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Bienvenido, Admin!'),
      ),
    );
  }
}
