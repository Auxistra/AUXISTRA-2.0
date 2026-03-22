import 'package:flutter/material.dart';

/// SongTagChip is a small label used to display
/// extra metadata about a track.
///
/// Examples:
/// - Explicit
/// - Remix
/// - HD Audio
/// - Live
///
/// These chips are commonly used in music apps
/// to give quick information about a song.
class SongTagChip extends StatelessWidget {
  /// Text displayed inside the chip
  final String label;

  /// Optional icon displayed before the text
  final IconData? icon;

  const SongTagChip({
    super.key,
    required this.label,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      /// Padding inside the chip for spacing
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),

      /// Visual styling of the chip
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey.shade700,
        ),
      ),

      /// Row to display icon + label
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// If an icon is provided, display it
          if (icon != null) ...[
            Icon(
              icon,
              size: 14,
              color: Colors.white,
            ),
            const SizedBox(width: 4),
          ],

          /// Label text
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
