import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/app/modules/movies/screens/movie_screen.dart';
import 'package:movie_app/app/services/authentication/api_service.dart';

class LoginController extends GetxController {
  final Auth _authService = Auth();

  // -------------------------
  // Reactive variables
  // -------------------------
  var isLoading = false.obs;
  var isPasswordHidden = true.obs;
  var token = ''.obs; // reactive token for mock or Firebase ID token

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // -------------------------
  // TOGGLE PASSWORD VISIBILITY
  // -------------------------
  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  // -------------------------
  // LOGIN WITH EMAIL & PASSWORD
  // -------------------------
  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showError('Email and password cannot be empty');
      return;
    }

    isLoading.value = true;

    try {
      final userCredential = await _authService.loginWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get Firebase token if using Firebase Auth
      final idToken = await userCredential.user?.getIdToken();
      token.value = idToken ?? '';

      _showSuccess('Login successful');
      _navigateToHome();
    } catch (e) {
      _showError('Login failed: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // -------------------------
  // NAVIGATION
  // -------------------------
  void goToResetPassword() {
    Get.toNamed("/reset_password");
  }

  void goToRegister() {
    Get.toNamed("/register");
  }

  void _navigateToHome() {
    Get.offAll(() => MovieScreen());
  }

  // -------------------------
  // SOCIAL LOGIN (MOCK)
  // -------------------------
  Future<void> signInWithFacebook() async => _mockSocialLogin("Facebook");

  Future<void> signInWithGoogle() async => _mockSocialLogin("Google");

  Future<void> signInWithTikTok() async => _mockSocialLogin("TikTok");

  Future<void> _mockSocialLogin(String provider) async {
    try {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 2)); // simulate API call

      token.value = "${provider.toLowerCase()}_mock_token"; // mock token

      _showSuccess("Signed in successfully with $provider");
      _navigateToHome();
    } catch (e) {
      _showError("$provider login failed: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // -------------------------
  // FEEDBACK HELPERS
  // -------------------------
  void _showSuccess(String message) {
    Get.snackbar(
      "Success",
      message,
      backgroundColor: Colors.green.shade600,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void _showError(String message) {
    Get.snackbar(
      "Error",
      message,
      backgroundColor: Colors.red.shade600,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // -------------------------
  // CLEANUP
  // -------------------------
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
