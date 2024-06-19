// lib/user_controller.dart
import 'package:get/get.dart';
import 'package:osvaldo_app/services/listaPersona.dart';

class UserController extends GetxController {
  var isLoading = true.obs;
  var userList = <dynamic>[].obs;

  final ApiService apiService = ApiService();

  @override
  void onInit() {
    fetchUsers();
    super.onInit();
  }

  void fetchUsers() async {
    try {
      isLoading(true);
      var users = await apiService.fetchUsers();
      userList.value = users;
    } finally {
      isLoading(false);
    }
  }
}
