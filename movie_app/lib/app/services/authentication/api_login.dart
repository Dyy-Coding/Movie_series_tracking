import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/app/data/api/auth.dart';

class AuthService extends GetxService {
  final String baseUrl = Api.baseUrl;

  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/auth/login');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // Decode JSON response
      return jsonDecode(response.body);
    } else {
      // Decode error
      return jsonDecode(response.body);
    }
  }
}
