import 'package:flutter/material.dart';

class NowPlayingProgressBar extends StatelessWidget {
  final Duration position;
  final Duration duration;
  final ValueChanged<Duration> onSeek;

  const NowPlayingProgressBar({
    super.key,
    required this.position,
    required this.duration,
    required this.onSeek,
  });

  String _formatTime(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final max =
        duration.inMilliseconds == 0 ? 1.0 : duration.inMilliseconds.toDouble();

    final value = position.inMilliseconds.clamp(0, max).toDouble();

    return Column(
      children: [

        /// Slider
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 3,
            thumbShape: const RoundSliderThumbShape(
              enabledThumbRadius: 6,
            ),
            overlayShape: const RoundSliderOverlayShape(
              overlayRadius: 12,
            ),
          ),
          child: Slider(
            value: value,
            min: 0,
            max: max,
            onChanged: (v) {
              onSeek(Duration(milliseconds: v.toInt()));
            },
          ),
        ),

        /// Time Labels
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Text(
                _formatTime(position),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[500],
                ),
              ),

              Text(
                _formatTime(duration),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
