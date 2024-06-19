import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osvaldo_app/views/detallePersona/detallePersona.dart';
import 'package:osvaldo_app/views/listaPersona/listaPersonaController.dart';

class UserListPage extends StatelessWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.put(UserController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
      ),
      body: Obx(() {
        if (userController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: userController.userList.length,
            itemBuilder: (context, index) {
              final user = userController.userList[index];
              return ListTile(
                title: Text(user['name']),
                subtitle: Text(user['email']),
                onTap: () {
                  Get.to(() => UserDetailPage(user: user));
                },
              );
            },
          );
        }
      }),
    );
  }
}
