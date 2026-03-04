import 'package:flutter/material.dart';

class FanEngagementCard extends StatelessWidget {
  final int likes;
  final int comments;
  final int shares;

  const FanEngagementCard({
    super.key,
    required this.likes,
    required this.comments,
    required this.shares,
  });

  Widget _buildStat(IconData icon, int value, Color color) {
    return Column(
      children: [
        Icon(icon, color: color),
        const SizedBox(height: 4),
        Text(
          value.toString(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStat(Icons.favorite, likes, Colors.pinkAccent),
          _buildStat(Icons.comment, comments, Colors.blueAccent),
          _buildStat(Icons.share, shares, Colors.greenAccent),
        ],
      ),
    );
  }
}
