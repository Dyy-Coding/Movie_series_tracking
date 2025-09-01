import 'package:flutter/material.dart';
import 'package:movie_app/app/utils/helpers/device_helpers.dart';

class SubmitButton extends StatefulWidget {
  const SubmitButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.backgroundColor,
    this.textColor,
    this.isLoading = false,
    this.height = 50,
    this.borderRadius = 12,
  });

  final VoidCallback onPressed;
  final String label;
  final Color? backgroundColor;
  final Color? textColor;
  final bool isLoading;
  final double height;
  final double borderRadius;

  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final width = UDevicesHelper.getScreenWidth(context);

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.isLoading ? null : widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: width,
        height: widget.height,
        decoration: BoxDecoration(
          gradient: widget.backgroundColor != null
              ? null
              : const LinearGradient(
                  colors: [Color(0xFFff6ec7), Color(0xFF8360c3)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          boxShadow: _isPressed
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    offset: const Offset(0, 6),
                    blurRadius: 12,
                  ),
                ],
        ),
        transform: _isPressed
            ? (Matrix4.identity()..scale(0.95))
            : Matrix4.identity(),
        alignment: Alignment.center,
        child: widget.isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Text(
                widget.label,
                style: TextStyle(
                  color: widget.textColor ?? Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.25),
                      offset: const Offset(0, 2),
                      blurRadius: 4,
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
