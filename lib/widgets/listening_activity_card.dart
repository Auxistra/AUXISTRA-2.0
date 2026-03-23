import 'package:flutter/material.dart';

class ListeningActivityCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final int listeners;
  final IconData icon;

  const ListeningActivityCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.listeners,
    this.icon = Icons.graphic_eq,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: const Color(0xFF1826F8).withOpacity(0.2),
            child: Icon(icon, color: const Color(0xFF1826F8)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(subtitle, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$listeners',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1826F8),
                ),
              ),
              const Text("listeners", style: TextStyle(color: Colors.grey)),
            ],
          )
        ],
      ),
    );
  }
}
