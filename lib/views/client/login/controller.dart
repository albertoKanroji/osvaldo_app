import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:osvaldo_app/services/client/login.dart';

class ClientController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final clientService = ClientService();
  final storage = GetStorage();

  void login() async {
    final email = emailController.text;
    final password = passwordController.text;
    final success = await clientService.login(email, password);
    if (success) {
      storage.write('role', 'client');
      Get.offNamed('/home-client');
    } else {
      Get.snackbar('Error', 'Login failed');
    }
  }
}
