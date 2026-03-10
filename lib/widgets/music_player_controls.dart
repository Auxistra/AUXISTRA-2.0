import 'package:flutter/material.dart';

/// Music player control buttons used in the Now Playing screen.
/// Includes:
/// - Previous track
/// - Play / Pause
/// - Next track
class MusicPlayerControls extends StatelessWidget {
  final VoidCallback? onPlayPause;
  final VoidCallback? onNext;
  final VoidCallback? onPrevious;

  /// Determines if music is currently playing
  final bool isPlaying;

  const MusicPlayerControls({
    super.key,
    this.onPlayPause,
    this.onNext,
    this.onPrevious,
    this.isPlaying = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        /// Previous track button
        IconButton(
          icon: const Icon(Icons.skip_previous),
          iconSize: 36,
          onPressed: onPrevious,
        ),

        const SizedBox(width: 20),

        /// Main Play/Pause button
        Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF1826F8),
          ),
          child: IconButton(
            icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
            iconSize: 40,
            color: Colors.white,
            onPressed: onPlayPause,
          ),
        ),

        const SizedBox(width: 20),

        /// Next track button
        IconButton(
          icon: const Icon(Icons.skip_next),
          iconSize: 36,
          onPressed: onNext,
        ),
      ],
    );
  }
}
