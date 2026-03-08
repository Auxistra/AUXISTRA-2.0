import 'package:flutter/material.dart';

class PlayCountWidget extends StatelessWidget {
  final int count;

  const PlayCountWidget({
    super.key,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.play_arrow, size: 18, color: Colors.white70),
        const SizedBox(width: 4),
        Text(
          "$count plays",
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        )
      ],
    );
  }
}
