import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:movie_app/app/common/widgets/button/submit_button.dart';
import 'package:movie_app/app/modules/authentication/controllers/login/login_controller.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.loginController,
  });

  final LoginController loginController;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 40, // Adjust position as needed
      left: 20,
      right: 20,
      child: Obx(
            () => SubmitButton(
          onPressed: loginController.login,
          label: "Sign in",
          isLoading: loginController.isLoading.value,
        ),
      ),
    );
  }
}
