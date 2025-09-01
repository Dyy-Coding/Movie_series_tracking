import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ForgotPassowrdAnimation extends StatelessWidget {
  const ForgotPassowrdAnimation({
    super.key,
    required this.animation,
  // added default text color
  });

  final String animation;


  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only( left: 16, right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Lottie animation
          SizedBox(
            height: 240, // fixed height for consistency
            child: Lottie.asset(animation, fit: BoxFit.contain),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
