import 'package:flutter/material.dart';

class PlaylistScreen extends StatelessWidget {
  const PlaylistScreen({super.key});

  Widget trackTile(String title, String artist, String duration) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 16),

      child: Row(
        children: [

          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFF1C1C1E),
              borderRadius: BorderRadius.circular(8),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                  ),
                ),

                Text(
                  artist,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),

          Text(
            duration,
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),

          children: [

            const SizedBox(height: 10),

            const Text(
              'Playlist',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.5,
              ),
            ),

            const SizedBox(height: 24),

            Center(
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  color: const Color(0xFF1C1C1E),
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),

            const SizedBox(height: 18),

            const Text(
              'Late Night Mix',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              '15 songs',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[400],
              ),
            ),

            const SizedBox(height: 18),

            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Shuffle',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            trackTile('Midnight Drive', 'Flux Artist', '3:42'),
            trackTile('Night Vision', 'Nova Sound', '4:02'),
            trackTile('Deep Waves', 'Luna Beats', '3:58'),
            trackTile('Neon Roads', 'DJ Flux', '4:10'),
            trackTile('After Hours', 'Echo Pulse', '3:33'),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
