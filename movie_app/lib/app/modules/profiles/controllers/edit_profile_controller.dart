import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final profileImage = Rx<File?>(null);
  final formKey = GlobalKey<FormState>();

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }


  Future<void> pickImage() async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (pickedFile != null) {
        profileImage.value = File(pickedFile.path);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick image: $e');
    }
  }
  void submitProfile() {
    if (formKey.currentState!.validate()) {
      // Handle save logic here
      print("Name: ${nameController.text}");
      print("Email: ${emailController.text}");
      print("Password: ${passwordController.text}");
      Get.snackbar(
        "Success",
        "Profile updated successfully",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF6A0DAD),
        colorText: const Color(0xFFFFFFFF),
      );
    }
  }
}
