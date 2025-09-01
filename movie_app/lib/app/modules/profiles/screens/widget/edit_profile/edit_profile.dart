import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/app/modules/profiles/controllers/edit_profile_controller.dart';
import 'package:movie_app/app/modules/profiles/screens/widget/edit_profile/edit_profile_element/profile_form_card.dart';
import 'package:movie_app/app/modules/profiles/screens/widget/edit_profile/edit_profile_element/profile_form_header.dart';
import 'package:movie_app/app/modules/profiles/screens/widget/edit_profile/edit_profile_element/save_button.dart';
import 'package:movie_app/app/utils/constants/colors.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EditProfileController>();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 255, 255, 255),
              Color.fromARGB(255, 255, 255, 255),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Fixed header at the top
              const ProfileHeader(),
              // Scrollable content
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 500,
                        minWidth: 300,
                      ),
                      child: AnimatedOpacity(
                        opacity: 1.0,
                        duration: const Duration(milliseconds: 500),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Profile image
                            Obx(() => Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black45,
                                            blurRadius: 8,
                                            offset: Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: CircleAvatar(
                                        radius: 60,
                                        backgroundColor: UColors.cardBackground,
                                        backgroundImage: controller.profileImage.value != null
                                            ? FileImage(controller.profileImage.value!)
                                            : null,
                                        child: controller.profileImage.value == null
                                            ? const Icon(
                                                Icons.person,
                                                size: 60,
                                                color: UColors.textSecondary,
                                              )
                                            : null,
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: GestureDetector(
                                        onTap: controller.pickImage,
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            gradient: LinearGradient(
                                              colors: [Color(0xFF6A0DAD), Color(0xFFFF4E50)],
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black26,
                                                blurRadius: 4,
                                                offset: Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          padding: const EdgeInsets.all(8),
                                          child: const Icon(
                                            Icons.camera_alt,
                                            color: Colors.yellow,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                            const SizedBox(height: 40),
                            Card(
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              color: const Color(0xFF2A2A4E),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: ProfileFormCard(
                                  formKey: controller.formKey,
                                  nameController: controller.nameController,
                                  emailController: controller.emailController,
                                  passwordController: controller.passwordController,
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            SaveButton(onPressed: controller.submitProfile),
                            const SizedBox(height: 32),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}