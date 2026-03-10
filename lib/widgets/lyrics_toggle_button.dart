import 'package:flutter/material.dart';

/// LyricsToggleButton is used to show or hide lyrics
/// in the Now Playing screen.
///
/// It indicates whether lyrics are currently visible.
class LyricsToggleButton extends StatelessWidget {
  /// Determines if lyrics are currently visible
  final bool isActive;

  /// Callback when the button is pressed
  final VoidCallback? onToggle;

  const LyricsToggleButton({
    super.key,
    this.isActive = false,
    this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.lyrics,
        color: isActive ? const Color(0xFF1826F8) : Colors.grey,
      ),
      tooltip: "Toggle lyrics",
      onPressed: onToggle,
    );
  }
}
