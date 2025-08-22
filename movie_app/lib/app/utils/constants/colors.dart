import 'package:flutter/material.dart';

/// App colors organized by usage context
class UColors {
  // ---------------- Core Backgrounds ----------------
  static const Color scaffoldBackground = Color(0xFF000000); // Dark theme base
  static const Color appBarBackground = Color(0xFF1E88E5);   // Main app bar color
  static const Color cardBackground = Color(0xFF212121);     // Movie/series card background
  static const Color sectionBackground = Color(0xFFF5F5F5); // Light sections or panels

  // ---------------- Text Colors ----------------
  static const Color textPrimary = Color(0xFFFFFFFF);   // Main text (white for dark bg)
  static const Color textSecondary = Colors.white54;    // Subtext / less emphasis
  static const Color textHighlight = Color(0xFF6AB7FF); // Highlighted text (blue light)

  // ---------------- Button Colors ----------------
  static const Color buttonBackground = Color(0xFF2979FF); // Primary action button
  static const Color buttonText = Color(0xFFFFFFFF);       // Button text (white)

  // ---------------- Borders & Dividers ----------------
  static const Color borderColor = Color(0xFF212121);  // Card & container borders
  static const Color dividerColor = Colors.black54;    // Divider lines

  // ---------------- Special Accents ----------------
  static const Color ratingStar = Color(0xFFFFD700);   // Gold for ratings
  static const Color progressTrack = Color(0xFF6AB7FF); // Tracking progress bar
  static const Color favoriteIcon = Color(0xFFE53935);  // Red for likes/favorites
}
