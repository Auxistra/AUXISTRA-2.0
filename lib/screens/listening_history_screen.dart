import 'package:flutter/material.dart';

class ListeningHistoryScreen extends StatelessWidget {
  const ListeningHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: const [

            SizedBox(height: 10),

            BigTitle(title: 'Recently Played'),

            SizedBox(height: 20),

            _HistoryItem(
              title: 'Midnight Signals',
              artist: 'Nova Arc',
            ),

            _HistoryItem(
              title: 'Echoes of You',
              artist: 'Lumen',
            ),

            _HistoryItem(
              title: 'Static Dreams',
              artist: 'Aurora Lane',
            ),

            _HistoryItem(
              title: 'Neon Silence',
              artist: 'Kairo',
            ),
          ],
        ),
      ),
    );
  }
}

class _HistoryItem extends StatelessWidget {
  final String title;
  final String artist;

  const _HistoryItem({
    required this.title,
    required this.artist,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [

          Artwork(size: 48),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  artist,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),

          Icon(
            Icons.play_arrow,
            color: Colors.grey[400],
          ),
        ],
      ),
    );
  }
}
