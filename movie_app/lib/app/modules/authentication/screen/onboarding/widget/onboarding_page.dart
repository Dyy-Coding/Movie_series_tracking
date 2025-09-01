import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key,
    required this.animation,
    required this.title,
    required this.subTitle,
    this.textColor = Colors.white, // added default text color
  });

  final String animation;
  final String title;
  final String subTitle;
  final Color textColor;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only( left: 16, right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Lottie animation
          SizedBox(
            height: 300, // fixed height for consistency
            child: Lottie.asset(animation, fit: BoxFit.contain),
          ),
          const SizedBox(height: 32),

          // Title
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),

          // Subtitle
          Text(
            subTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: textColor.withOpacity(0.9),
                ),
          ),
        ],
      ),
    );
  }
}
