import 'package:get/get.dart';

class ClientService extends GetxService {
  Future<bool> login(String email, String password) async {
    // Simulación de login
    await Future.delayed(Duration(seconds: 2)); // Simula una llamada a la API
    if (email == 'qwerty' && password == '123') {
      return true;
    }
    return false;
  }
}
