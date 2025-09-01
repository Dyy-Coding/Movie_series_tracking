import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/app/data/api/auth.dart';
import 'package:movie_app/app/modules/movies/screens/movie_screen.dart';

class LoginController extends GetxController {
  /// Observables
  var isLoading = false.obs;
  var token = ''.obs;
  var isPasswordHidden = true.obs;

  /// Text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  /// API Base URL
  final String baseUrl = Api.baseUrl;

  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    // Input validation
    if (email.isEmpty || password.isEmpty) {
      _showError("Email and password cannot be empty");
      return;
    }

    isLoading.value = true;

    try {
      final url = Uri.parse('$baseUrl/login');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          // Add any custom headers here if needed
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      // Decode response
      final responseData = jsonDecode(response.body);

      // Check response status
      if (response.statusCode == 200) {
        if (responseData['success'] == true && responseData['data'] != null) {
          final accessToken = responseData['data']['access_token'];

          if (accessToken != null && accessToken is String) {
            token.value = accessToken;
            _showSuccess(responseData['message'] ?? "Login successful");
            _navigateToHome();
          } else {
            _showError("Invalid token received from server.");
          }
        } else {
          _showError(responseData['message'] ?? "Login failed.");
        }
      } else {
        _showError("Login failed: ${responseData['message'] ?? 'Unexpected error'}");
      }
    } catch (e) {
      _showError("Something went wrong: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }


  /// Navigate to Reset Password screen
  void goToResetPassword() {
    Get.toNamed("/reset_password"); // Make sure this route exists
  }

  /// -------------------------
  /// TOGGLE PASSWORD VISIBILITY
  /// -------------------------
  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  /// -------------------------
  /// NAVIGATION
  /// -------------------------
  void goToRegister() {
    Get.toNamed("/register"); // Adjust route if needed
  }

  void _navigateToHome() {
    Get.offAll(() => MovieScreen());
  }

  /// -------------------------
  /// SOCIAL LOGIN (Mock)
  /// -------------------------
  Future<void> signInWithFacebook() async {
    await _mockSocialLogin("Facebook");
  }

  Future<void> signInWithGoogle() async {
    await _mockSocialLogin("Google");
  }

  Future<void> signInWithTikTok() async {
    await _mockSocialLogin("TikTok");
  }

  Future<void> _mockSocialLogin(String provider) async {
    try {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 2)); // simulate API call
      token.value = "${provider.toLowerCase()}_mock_token";
      _showSuccess("Signed in successfully with $provider");
      _navigateToHome();
    } catch (e) {
      _showError("$provider login failed: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// -------------------------
  /// FEEDBACK HELPERS
  /// -------------------------
  void _showSuccess(String message) {
    Get.snackbar("Success", message,
        backgroundColor: Colors.green.shade600,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM);
  }

  void _showError(String message) {
    Get.snackbar("Error", message,
        backgroundColor: Colors.red.shade600,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM);
  }

  /// -------------------------
  /// CLEANUP
  /// -------------------------
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
