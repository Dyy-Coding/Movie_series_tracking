import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';
import 'package:movie_app/app/modules/authentication/controllers/login/login_controller.dart';
import 'package:movie_app/app/utils/constants/sizes.dart';

class EmailField extends StatelessWidget {
  const EmailField({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = Get.find<LoginController>();

    return Positioned(
      top: 50, // Example position, adjust as needed
      left: 20,
      right: 20,
      child: TextFormField(
        controller: loginController.emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          prefixIcon: const Icon(Iconsax.direct_right),
          hintText: 'Email',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(USizes.radiusSmall),
          ),
        ),
      ),
    );
  }
}
