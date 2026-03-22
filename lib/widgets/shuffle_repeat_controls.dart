import 'package:flutter/material.dart';

/// Control widget for shuffle and repeat playback modes.
/// Used in advanced music players.
class ShuffleRepeatControls extends StatelessWidget {
  final bool shuffleEnabled;
  final bool repeatEnabled;

  final VoidCallback? onShuffle;
  final VoidCallback? onRepeat;

  const ShuffleRepeatControls({
    super.key,
    this.shuffleEnabled = false,
    this.repeatEnabled = false,
    this.onShuffle,
    this.onRepeat,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// Shuffle button
        IconButton(
          icon: Icon(
            Icons.shuffle,
            color: shuffleEnabled ? const Color(0xFF1826F8) : Colors.grey,
          ),
          onPressed: onShuffle,
        ),

        /// Repeat button
        IconButton(
          icon: Icon(
            Icons.repeat,
            color: repeatEnabled ? const Color(0xFF1826F8) : Colors.grey,
          ),
          onPressed: onRepeat,
        ),
      ],
    );
  }
}
