import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/app/modules/authentication/controllers/register/register_controller.dart';
import 'package:movie_app/app/common/widgets/button/social_button.dart';

class FooterRegister extends StatelessWidget {
  const FooterRegister({
    super.key,
    required this.registerController,
  });

  final RegisterController registerController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Already have account? -> Login
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Already have an account? "),
            GestureDetector(
              onTap: registerController.goToLogin,
              child: Text(
                "Login",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        // Divider with text
        Row(
          children: [
            Expanded(child: Divider(thickness: 1)), // removed const
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: const Text("or continue with"),
            ),
            Expanded(child: Divider(thickness: 1)), // removed const
          ],
        ),

        const SizedBox(height: 20),

        // Social login buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SocialButton(
              icon: Icons.facebook,
              color: Colors.blue,
              onTap: registerController.signInWithFacebook,
            ),
            const SizedBox(width: 16),
            SocialButton(
              icon: Icons.mail,
              color: Colors.red,
              onTap: registerController.signInWithGoogle,
            ),
            const SizedBox(width: 16),
            SocialButton(
              icon: CupertinoIcons.play_circle, // Placeholder for TikTok
              color: Colors.black,
              onTap: registerController.signInWithTikTok,
            ),
          ],
        ),
      ],
    );
  }
}
