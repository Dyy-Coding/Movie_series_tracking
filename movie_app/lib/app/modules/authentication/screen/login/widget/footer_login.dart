import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/app/common/widgets/button/social_button.dart';
import 'package:movie_app/app/modules/authentication/controllers/login/login_controller.dart';

class FooterLogin extends StatelessWidget {
  const FooterLogin({
    super.key,
    required this.loginController,
  });

  final LoginController loginController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Reset password
        GestureDetector(
          onTap: loginController.goToResetPassword,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Text(
              "Forgot Password?",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),

        /// Don't have account? -> Register
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Don't have an account? "),
            GestureDetector(
              onTap: loginController.goToRegister,
              child: Text(
                "Register",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        /// Divider with text
        Row(
          children: const [
            Expanded(child: Divider(thickness: 1)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text("or continue with"),
            ),
            Expanded(child: Divider(thickness: 1)),
          ],
        ),

        const SizedBox(height: 20),

        /// Social login buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SocialButton(
              icon: Icons.facebook,
              color: Colors.blue,
              onTap: loginController.signInWithFacebook,
            ),
            const SizedBox(width: 16),
            SocialButton(
              icon: Icons.mail,
              color: Colors.red,
              onTap: loginController.signInWithGoogle,
            ),
            const SizedBox(width: 16),
            SocialButton(
              icon: CupertinoIcons.play_circle, // TikTok placeholder
              color: Colors.black,
              onTap: loginController.signInWithTikTok,
            ),
          ],
        ),
      ],
    );
  }
}
