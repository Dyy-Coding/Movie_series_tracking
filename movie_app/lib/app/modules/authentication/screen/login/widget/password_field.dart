import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';
import 'package:movie_app/app/modules/authentication/controllers/login/login_controller.dart';
import 'package:movie_app/app/utils/constants/sizes.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = Get.find<LoginController>();

    return Positioned(
      top: 120, // Adjust position as needed
      left: 20,
      right: 20,
      child: Obx(
            () => TextFormField(
          controller: loginController.passwordController,
          obscureText: loginController.isPasswordHidden.value,
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            labelText: 'Password',
            hintText: 'Enter your password',
            prefixIcon: const Icon(Iconsax.lock),
            suffixIcon: IconButton(
              icon: Icon(
                loginController.isPasswordHidden.value
                    ? Iconsax.eye_slash
                    : Iconsax.eye, // toggle icon
              ),
              onPressed: loginController.togglePasswordVisibility,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(USizes.radiusMedium),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Password is required';
            } else if (value.length < 6) {
              return 'Password must be at least 6 characters';
            }
            return null;
          },
        ),
      ),
    );
  }
}
