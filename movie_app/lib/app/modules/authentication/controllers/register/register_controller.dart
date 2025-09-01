import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/app/modules/authentication/screen/login/login.dart';
import 'package:movie_app/app/modules/movies/screens/movie_screen.dart';
import 'package:movie_app/app/services/authentication/api_service.dart';

class RegisterController extends GetxController {
  final AuthService _authService = AuthService();

  var isLoading = false.obs;
  var token = ''.obs;
  var isPasswordHidden = true.obs;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  /// Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  /// Navigate to Login screen
  void goToLogin() {
    Get.to(() => LoginScreen());
  }

  /// Register with API using AuthService
  Future<void> register() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final passwordConfirm = confirmPasswordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty || passwordConfirm.isEmpty) {
      Get.snackbar('Error', 'All fields are required');
      return;
    }

    if (password != passwordConfirm) {
      Get.snackbar('Error', 'Passwords do not match');
      return;
    }

    isLoading.value = true;

    try {
      final result = await _authService.registerUser(
        name: name,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirm,
      );

      final statusCode = result['statusCode'];
      final responseData = result['body'];

      if (statusCode == 200 && responseData['success'] == true) {
        final accessToken = responseData['data']['access_token'];
        token.value = accessToken;

        Get.snackbar('Success', responseData['message'] ?? 'Registered successfully');
        Get.offAll(() => MovieScreen());
      } else {
        Get.snackbar('Error', responseData['message'] ?? 'Registration failed');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// -------------------------
  /// Mock Social Logins
  /// -------------------------
  Future<void> signInWithFacebook() async {
    await _mockSocialLogin('Facebook', 'facebook_mock_token');
  }

  Future<void> signInWithGoogle() async {
    await _mockSocialLogin('Google', 'google_mock_token');
  }

  Future<void> signInWithTikTok() async {
    await _mockSocialLogin('TikTok', 'tiktok_mock_token');
  }

  Future<void> _mockSocialLogin(String platform, String mockToken) async {
    try {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 2));
      token.value = mockToken;
      Get.snackbar("$platform Login", "Signed in successfully with $platform");
      Get.offAll(() => MovieScreen());
    } catch (e) {
      Get.snackbar("Error", "$platform login failed: $e");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
