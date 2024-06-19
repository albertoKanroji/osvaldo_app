import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:osvaldo_app/environment.dart';

class ApiService {
  final String baseUrl = Environment.baseUrl;

  Future<List<dynamic>> fetchUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/users'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load users');
    }
  }
}
