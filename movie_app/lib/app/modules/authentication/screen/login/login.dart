import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/app/common/style/padding.dart';
import 'package:movie_app/app/modules/authentication/controllers/login/login_controller.dart';
import 'package:movie_app/app/modules/authentication/screen/login/widget/email_field.dart';
import 'package:movie_app/app/modules/authentication/screen/login/widget/footer_login.dart';
import 'package:movie_app/app/modules/authentication/screen/login/widget/login_animation.dart';
import 'package:movie_app/app/modules/authentication/screen/login/widget/login_button.dart';
import 'package:movie_app/app/modules/authentication/screen/login/widget/password_field.dart';
import 'package:movie_app/app/utils/constants/images.dart';
import 'package:movie_app/app/utils/constants/sizes.dart';
import 'package:movie_app/app/utils/constants/texts..dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = Get.put(LoginController());

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: UPadding.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              loginAnimation(animation: Uimages.loginAnimation),
              /// Header
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    UTexts.loginTitle,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  SizedBox(height: USizes.spaceMedium),
                  Text(
                    UTexts.loginSubTitle,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              SizedBox(height: USizes.spaceLarge),

              /// Form fields
              const EmailField(),
              SizedBox(height: USizes.spaceExtra),
              const PasswordField(),
              SizedBox(height: USizes.spaceLarge),

              /// Login button
              LoginButton(loginController: loginController),
              SizedBox(height: USizes.spaceLarge),

              /// Footer
              FooterLogin(loginController: loginController),

              SizedBox(height: USizes.spaceLarge),

            ],
          ),
        ),
      ),
    );
  }
}




