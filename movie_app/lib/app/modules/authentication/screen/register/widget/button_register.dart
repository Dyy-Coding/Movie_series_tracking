import 'package:flutter/cupertino.dart';
import 'package:movie_app/app/common/widgets/button/submit_button.dart';
import 'package:movie_app/app/modules/authentication/controllers/register/register_controller.dart';

class ButtonRegister extends StatelessWidget {
  const ButtonRegister({
    super.key,
    required this.registerController,
  });

  final RegisterController registerController;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,

      left: 20,
      right: 20,
      child: SubmitButton(
        onPressed: registerController.register,
        label: 'Register',
        isLoading: registerController.isLoading.value,
      ),
    );
  }
}

