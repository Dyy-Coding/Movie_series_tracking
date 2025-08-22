import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/app/data/api/auth.dart';
import 'package:movie_app/app/modules/home/screens/home_screen.dart';

class LoginController extends GetxController {
  // Observables
  var isLoading = false.obs;
  var token = ''.obs;

  // Text controllers for input fields
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // API Base URL
  final String baseUrl = Api.baseUrl;

  // Login method
  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Email and password cannot be empty');
      return;
    }

    isLoading.value = true;

    try {
      final url = Uri.parse('$baseUrl/login');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData['success'] == true) {
        token.value = responseData['data']['access_token'];
        Get.snackbar('Success', responseData['message']);
        // Navigate to next screen if needed
        Get.to(() => HomeScreen()); // Replace with your home screen widget
      } else {
        Get.snackbar('Error', responseData['message'] ?? 'Login failed');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Dispose text controllers
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
