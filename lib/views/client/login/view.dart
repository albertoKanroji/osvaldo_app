import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osvaldo_app/views/client/login/controller.dart';

class LoginClientPage extends StatelessWidget {
  final ClientController controller = Get.put(ClientController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Cliente'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controller.emailController,
              decoration: InputDecoration(labelText: 'Correo'),
            ),
            TextField(
              controller: controller.passwordController,
              decoration: InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: controller.login,
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () => Get.toNamed('/login-admin'),
              child: Text('¿Eres admin?'),
            ),
          ],
        ),
      ),
    );
  }
}
