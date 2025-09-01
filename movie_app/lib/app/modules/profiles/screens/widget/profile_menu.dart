import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/app/modules/profiles/controllers/profile_controller.dart';

class TriangleMenu extends StatelessWidget {
  const TriangleMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();

    return Material(
      elevation: 4,
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 180, // minimum width
          maxWidth: 220, // maximum width
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // auto-size vertically
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Triangle pointer
            Align(
              alignment: Alignment.topRight,
              child: CustomPaint(
                painter: _TrianglePainter(color: Colors.white),
                child: const SizedBox(width: 20, height: 10),
              ),
            ),
            _MenuItem(
              icon: Icons.settings,
              label: "Settings",
              onTap: () {
                controller.openSettings();
                controller.toggleMenu();
              },
            ),
            _MenuItem(
              icon: Icons.edit,
              label: "Edit Profile",
              onTap: () {
                controller.editProfile();
                controller.toggleMenu();
              },
            ),
            _MenuItem(
              icon: Icons.logout,
              label: "Logout",
              onTap: () {
                controller.logout();
                controller.toggleMenu();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      minLeadingWidth: 0,
      visualDensity: const VisualDensity(vertical: -2),
      leading: Icon(icon, size: 20),
      title: Text(label),
      onTap: onTap,
    );
  }
}

class _TrianglePainter extends CustomPainter {
  final Color color;
  _TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width / 2, 0)
      ..lineTo(size.width, size.height)
      ..close();
    canvas.drawPath(path, paint);

    // subtle border
    final border = Paint()
      ..color = Colors.black.withOpacity(0.08)
      ..style = PaintingStyle.stroke;
    canvas.drawPath(path, border);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
