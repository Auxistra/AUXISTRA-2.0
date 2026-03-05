import 'package:flutter/material.dart';

/// WaveformVisualizer
/// Displays animated bars to simulate audio playing.
/// This is commonly used in music players and remix apps.
class WaveformVisualizer extends StatelessWidget {
  final bool isPlaying;

  const WaveformVisualizer({
    super.key,
    required this.isPlaying,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        20, // Number of waveform bars
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 2),

          /// Height changes when music is playing
          height: isPlaying
              ? (10 + (index % 5) * 8).toDouble()
              : 10,

          width: 4,
          decoration: BoxDecoration(
            color: Colors.greenAccent,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
