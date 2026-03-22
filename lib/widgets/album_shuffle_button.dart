import 'package:flutter/material.dart';

class AlbumShuffleButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AlbumShuffleButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.shuffle),
      label: const Text("Shuffle Play"),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
