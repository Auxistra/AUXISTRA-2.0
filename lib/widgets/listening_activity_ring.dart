import 'package:flutter/material.dart';

class ListeningActivityRing extends StatelessWidget {
  final double progress; // 0.0 → 1.0
  final String label;

  const ListeningActivityRing({
    super.key,
    required this.progress,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 70,
          height: 70,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircularProgressIndicator(
                value: progress,
                strokeWidth: 6,
                backgroundColor: Colors.white12,
                valueColor:
                    const AlwaysStoppedAnimation(Colors.pinkAccent),
              ),
              Text(
                "${(progress * 100).toInt()}%",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(color: Colors.white70),
        )
      ],
    );
  }
}
