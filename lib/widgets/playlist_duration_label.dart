import 'package:flutter/material.dart';

class PlaylistDurationLabel extends StatelessWidget {
  final String duration;

  const PlaylistDurationLabel({super.key, required this.duration});

  @override
  Widget build(BuildContext context) {
    return Text(
      duration,
      style: const TextStyle(
        color: Colors.grey,
        fontSize: 12,
      ),
    );
  }
}
