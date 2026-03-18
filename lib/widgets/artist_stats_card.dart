import 'package:flutter/material.dart';

/// ArtistStatsCard displays quick statistics about an artist.
///
/// It can be used in:
/// - Artist profile page
/// - Artist dashboard
///
/// Example stats:
/// - Monthly listeners
/// - Followers
/// - Total tracks
class ArtistStatsCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const ArtistStatsCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C),
        borderRadius: BorderRadius.circular(14),
      ),

      child: Row(
        children: [
          /// Icon representing the statistic
          Icon(icon, size: 28, color: Colors.white),

          const SizedBox(width: 12),

          /// Statistic information
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Value (large number)
              Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              /// Label describing the stat
              Text(
                title,
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          )
        ],
      ),
    );
  }
}
