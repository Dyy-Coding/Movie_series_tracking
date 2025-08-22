import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UDevicesHelper {
  // Private constructor to prevent instantiation
  UDevicesHelper._();

  /// Hide the keyboard
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  /// Set Status Bar Color
  static Future<void> setStatusBarColor(Color color) async {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: color),
    );
  }

  /// Check if device is in landscape orientation
  static bool isLandscapeOrientation(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  /// Enable or disable fullscreen mode
  static void setFullScreen(bool enable) {
    if (enable) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    }
  }

  /// Get screen height
  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  /// Get screen width
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /// Get default AppBar height
  static double getAppBarHeight() {
    return kToolbarHeight; // Default = 56.0
  }

  /// Get keyboard height (returns 0 if closed)
  static double getKeyboardHeight(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom;
  }

  /// Get default BottomNavigationBar height
  static double getBottomNavigationBarHeight() {
    return kBottomNavigationBarHeight; // Default = 56.0
  }
}
