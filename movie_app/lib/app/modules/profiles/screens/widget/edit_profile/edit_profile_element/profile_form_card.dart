import 'package:flutter/material.dart';
import 'package:movie_app/app/modules/profiles/screens/widget/field/inputfeild.dart';

class ProfileFormCard extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const ProfileFormCard({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
    
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(95, 255, 255, 255),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            InputField(
              label: "Name",
              hint: "Enter your full name",
              controller: nameController,
              validator: (value) {
                if (value == null || value.isEmpty) return "Name is required";
                return null;
              },
            ),
            const SizedBox(height: 16),
            InputField(
              label: "Email",
              hint: "Enter your email",
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) return "Email is required";
                if (!value.contains('@')) return "Enter a valid email";
                return null;
              },
            ),
            const SizedBox(height: 16),
            InputField(
              label: "Password",
              hint: "Enter your password",
              controller: passwordController,
              isPassword: true,
              validator: (value) {
                if (value == null || value.isEmpty) return "Password is required";
                if (value.length < 6) return "Password must be at least 6 characters";
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
