import 'package:get/get.dart';

class AdminService extends GetxService {
  Future<bool> login(String email, String password) async {
    // Simulación de login
    await Future.delayed(Duration(seconds: 2)); // Simula una llamada a la API
    if (email == 'admin@example.com' && password == 'password') {
      return true;
    }
    return false;
  }
}
