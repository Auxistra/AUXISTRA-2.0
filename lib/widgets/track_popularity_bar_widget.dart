import 'package:flutter/material.dart';

class TrackPopularityBar extends StatelessWidget {
  final double popularity; // value between 0 and 1
  final String label;

  const TrackPopularityBar({
    super.key,
    required this.popularity,
    this.label = "Popularity",
  });

  @override
  Widget build(BuildContext context) {
    final percent = (popularity * 100).round();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label.toUpperCase(),
              style: TextStyle(
                fontSize: 12,
                letterSpacing: 1.1,
                color: Colors.grey[500],
              ),
            ),
            Text(
              "$percent%",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[400],
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),

        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: LinearProgressIndicator(
            value: popularity,
            minHeight: 6,
            backgroundColor: const Color(0xFF2A2A2A),
            valueColor: const AlwaysStoppedAnimation(Color(0xFFFFFFFF)),
          ),
        ),
      ],
    );
  }
}
