import 'package:flutter/material.dart';

class MusicCover extends StatelessWidget {
  final double size;
  final bool glow;

  const MusicCover({
    super.key,
    this.size = 250,
    this.glow = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C),
        borderRadius: BorderRadius.circular(16),
        boxShadow: glow
            ? [
                BoxShadow(
                  color: const Color(0xFF1826F8).withOpacity(0.5),
                  blurRadius: 30,
                  spreadRadius: 6,
                )
              ]
            : [],
      ),
      child: const Icon(Icons.music_note,
          size: 80, color: Colors.white),
    );
  }
}
