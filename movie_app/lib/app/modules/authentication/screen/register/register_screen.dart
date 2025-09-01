import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';
import 'package:movie_app/app/common/style/padding.dart';
import 'package:movie_app/app/modules/authentication/screen/register/widget/button_register.dart';
import 'package:movie_app/app/modules/authentication/screen/register/widget/footer_register.dart';
import 'package:movie_app/app/utils/constants/sizes.dart';
import 'package:movie_app/app/utils/constants/texts..dart';
import 'package:movie_app/app/modules/authentication/controllers/register/register_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: UPadding.screenPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ///-----[Header]------
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        UTexts.registerTitle,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      SizedBox(height: USizes.spaceMedium),
                      Text(
                        UTexts.registerSubTitle,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),

                  SizedBox(height: USizes.spaceLarge),

                  ///-----[Form Fields]------
                  TextFormField(
                    controller: registerController.nameController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Iconsax.user),
                      hintText: 'Full Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(USizes.radiusSmall),
                      ),
                    ),
                  ),

                  SizedBox(height: USizes.spaceExtra),

                  TextFormField(
                    controller: registerController.emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Iconsax.direct_right),
                      hintText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(USizes.radiusSmall),
                      ),
                    ),
                  ),

                  SizedBox(height: USizes.spaceExtra),

                  TextFormField(
                    controller: registerController.passwordController,
                    obscureText: registerController.isPasswordHidden.value,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Iconsax.lock),
                      suffixIcon: IconButton(
                        icon: Icon(registerController.isPasswordHidden.value
                            ? Iconsax.eye_slash
                            : Iconsax.eye),
                        onPressed: () {
                          setState(() {
                            registerController.togglePasswordVisibility();
                          });
                        },
                      ),
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(USizes.radiusMedium),
                      ),
                    ),
                  ),

                  SizedBox(height: USizes.spaceExtra),

                  TextFormField(
                    controller: registerController.confirmPasswordController,
                    obscureText: registerController.isPasswordHidden.value,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Iconsax.lock),
                      hintText: 'Confirm Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(USizes.radiusMedium),
                      ),
                    ),
                  ),
                  SizedBox(height: USizes.spaceLarge),

                  ///-----[Register Button Positioned]------
                  ButtonRegister(registerController: registerController),
                  SizedBox(height: USizes.spaceLarge),

                  ///-----[Footer Links]------
                  FooterRegister(registerController: registerController),


                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
}

