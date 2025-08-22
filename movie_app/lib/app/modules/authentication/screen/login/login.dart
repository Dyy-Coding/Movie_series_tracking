import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:movie_app/app/common/style/padding.dart';
import 'package:movie_app/app/utils/constants/sizes.dart';
import 'package:movie_app/app/utils/constants/texts..dart';
import 'package:movie_app/app/modules/authentication/controllers/login/login_controller.dart';
import 'package:get/get.dart';

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///-----[Header]------
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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

              ///-----[Form]------
              TextFormField(
                controller: loginController.emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: Icon(Iconsax.direct_right),
                  hintText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(USizes.radiusSmall),
                  ),
                ),
              ),

              SizedBox(height: USizes.spaceExtra),

              TextFormField(
                controller: loginController.passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Iconsax.directbox_receive),
                  hintText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(USizes.radiusMedium),
                  ),
                ),
              ),

              SizedBox(height: USizes.spaceLarge),

              ///-----[Login Button]------
              Obx(() {
                return loginController.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    : SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            loginController.login();
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      );
              }),

              SizedBox(height: USizes.spaceMedium),

              ///-----[Footer Links]------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      // Navigate to Forgot Password
                    },
                    child: Text('Forgot Password?'),
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigate to Sign Up screen
                    },
                    child: Text('Sign Up'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
