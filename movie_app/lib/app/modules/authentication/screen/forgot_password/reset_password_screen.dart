import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/app/common/widgets/button/submit_button.dart';
import 'package:movie_app/app/modules/authentication/controllers/reset_password/reset_password_controller.dart';
import 'package:movie_app/app/modules/authentication/screen/forgot_password/forgot_password_animation.dart';
import 'package:movie_app/app/utils/constants/images.dart';
import 'package:movie_app/app/utils/constants/sizes.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ResetPasswordController());

    return Scaffold(
      appBar: AppBar(title: const Text("Reset Password")),
      body: Padding(
        padding: const EdgeInsets.all(USizes.spaceMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ForgotPassowrdAnimation(animation: Uimages.resetpasswirdAnimation),
            const Text(
              "Enter your email to reset your password",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: controller.emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Obx(() => SubmitButton(
                 onPressed: controller.resetPassword,
                 label: "Reset Password",
                 isLoading: controller.isLoading.value,
            ) ),
          ],
        ),
      ),
    );
  }
}
