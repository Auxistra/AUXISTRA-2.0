import 'package:flutter/material.dart';

/// SongPopularityIndicator visually represents
/// how popular a track is using a progress bar.
///
/// The value should be between 0 and 100.
class SongPopularityIndicator extends StatelessWidget {
  /// Popularity score (0–100)
  final int popularity;

  const SongPopularityIndicator({
    super.key,
    required this.popularity,
  });

  @override
  Widget build(BuildContext context) {
    final double normalized = popularity / 100;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Label for clarity
        const Text(
          "Popularity",
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),

        const SizedBox(height: 4),

        /// Progress bar representing popularity level
        LinearProgressIndicator(
          value: normalized,
          minHeight: 6,
          backgroundColor: Colors.grey.shade300,
        ),

        const SizedBox(height: 2),

        /// Display numeric popularity value
        Text(
          "$popularity%",
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
