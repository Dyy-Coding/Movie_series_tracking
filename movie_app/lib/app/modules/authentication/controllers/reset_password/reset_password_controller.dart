import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/app/data/api/auth.dart';

class ResetPasswordController extends GetxController {
  var isLoading = false.obs;
  final emailController = TextEditingController();
  final String baseUrl = Api.baseUrl;

  /// Request password reset
  Future<void> resetPassword() async {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      Get.snackbar("Error", "Email is required");
      return;
    }

    isLoading.value = true;

    try {
      final url = Uri.parse('$baseUrl/reset-password'); // adjust to your API
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email}),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData['success'] == true) {
        Get.snackbar("Success", responseData['message'] ?? "Password reset link sent to email");
        Get.back(); // go back to login
      } else {
        Get.snackbar("Error", responseData['message'] ?? "Reset failed");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
