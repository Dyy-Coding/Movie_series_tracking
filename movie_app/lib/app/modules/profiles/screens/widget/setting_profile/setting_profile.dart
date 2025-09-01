import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/app/modules/profiles/controllers/theme_controller.dart';
import 'package:movie_app/app/utils/constants/colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1A1A2E),
              Color(0xFF2A2A4E),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Fixed header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF6A0DAD), Color(0xFFFF4E50)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const Text(
                      "Settings",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 24), // Spacer for symmetry
                  ],
                ),
              ),
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
                        child: Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          color: const Color(0xFF2A2A4E),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Appearance',
                                  style: Theme.of(context).textTheme.headlineMedium,
                                ),
                                const SizedBox(height: 8),
                                GetBuilder<ThemeController>(
                                  builder: (controller) => ListTile(
                                    leading: Icon(
                                      Icons.brightness_6,
                                      color: Theme.of(context).textTheme.bodyLarge?.color,
                                    ),
                                    title: Text(
                                      'Dark Mode',
                                      style: Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    subtitle: Text(
                                      'Toggle between dark and light themes',
                                      style: Theme.of(context).textTheme.bodyMedium,
                                    ),
                                    trailing: Switch(
                                      value: controller.isDarkMode.value,
                                      onChanged: controller.toggleTheme,
                                      activeColor: const Color(0xFFFF4E50),
                                      inactiveTrackColor: UColors.textSecondary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
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