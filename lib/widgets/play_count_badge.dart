import 'package:flutter/material.dart';

/// PlayCountBadge displays how many times a song or track
/// has been played. This is useful for:
/// - Trending songs
/// - Track popularity
/// - Artist dashboards
class PlayCountBadge extends StatelessWidget {
  /// Number of plays for the track
  final int playCount;

  const PlayCountBadge({
    super.key,
    required this.playCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),

      /// Visual styling for the badge
      decoration: BoxDecoration(
        color: const Color(0xFF1826F8),
        borderRadius: BorderRadius.circular(12),
      ),

      /// Row to display icon + play count
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Play icon
          const Icon(
            Icons.play_arrow,
            size: 16,
            color: Colors.white,
          ),

          const SizedBox(width: 4),

          /// Play count text
          Text(
            playCount.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
