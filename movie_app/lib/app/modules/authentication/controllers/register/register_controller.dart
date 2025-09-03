import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/app/modules/authentication/screen/login/login.dart';
import 'package:movie_app/app/modules/movies/screens/movie_screen.dart';
import 'package:movie_app/app/services/authentication/api_service.dart';

class RegisterController extends GetxController {
  final Auth _authService = Auth();

  // -------------------------
  // Reactive variables
  // -------------------------
  var isLoading = false.obs;
  var token = ''.obs; // Firebase ID token or mock token
  var isPasswordHidden = true.obs;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // -------------------------
  // Toggle password visibility
  // -------------------------
  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  // -------------------------
  // Navigate to Login screen
  // -------------------------
  void goToLogin() {
    Get.to(() => LoginScreen());
  }

  // -------------------------
  // REGISTER WITH EMAIL & PASSWORD
  // -------------------------
  Future<void> register() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final passwordConfirm = confirmPasswordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty || passwordConfirm.isEmpty) {
      _showError('All fields are required');
      return;
    }

    if (password != passwordConfirm) {
      _showError('Passwords do not match');
      return;
    }

    isLoading.value = true;

    try {
      final userCredential = await _authService.registerWithEmailAndPassword(
        name: name,
        email: email,
        password: password,
        passwordConfirm: passwordConfirm,
      );

      // Get Firebase ID token
      final idToken = await userCredential.user?.getIdToken();
      token.value = idToken ?? '';

      _showSuccess('Registered successfully');
      Get.offAll(() => MovieScreen());
    } catch (e) {
      _showError('Registration failed: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // -------------------------
  // SOCIAL LOGIN (Mock)
  // -------------------------
  Future<void> signInWithFacebook() async =>
      _mockSocialLogin('Facebook', 'facebook_mock_token');

  Future<void> signInWithGoogle() async =>
      _mockSocialLogin('Google', 'google_mock_token');

  Future<void> signInWithTikTok() async =>
      _mockSocialLogin('TikTok', 'tiktok_mock_token');

  Future<void> _mockSocialLogin(String platform, String mockToken) async {
    try {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 2));
      token.value = mockToken;
      _showSuccess("Signed in successfully with $platform");
      Get.offAll(() => MovieScreen());
    } catch (e) {
      _showError("$platform login failed: $e");
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
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
