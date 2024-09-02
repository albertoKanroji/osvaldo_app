import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:osvaldo_app/services/admin/login.dart';

class AdminController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final adminService = Get.find<AdminService>();
  final storage = GetStorage();

  void login() async {
    final email = emailController.text;
    final password = passwordController.text;
    final success = await adminService.login(email, password);
    if (success) {
      storage.write('role', 'admin');
      Get.offNamed('/home-admin');
    } else {
      Get.snackbar('Error', 'Login failed');
    }
  }
}
