import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final String initials;
  final double radius;

  const UserAvatar({
    super.key,
    required this.initials,
    this.radius = 24,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: const Color(0xFF1826F8),
      child: Text(
        initials,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
