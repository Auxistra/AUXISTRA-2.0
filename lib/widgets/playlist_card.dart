import 'package:flutter/material.dart';

/// PlaylistCard
/// A reusable widget used to display playlists in the app.
/// Example: "Chill Mix", "Workout Beats", "Recently Played".
class PlaylistCard extends StatelessWidget {
  final String playlistName;
  final String coverImage;
  final int trackCount;
  final VoidCallback onTap;

  const PlaylistCard({
    super.key,
    required this.playlistName,
    required this.coverImage,
    required this.trackCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Opens the playlist page
      child: Container(
        width: 160,
        margin: const EdgeInsets.only(right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Playlist Cover Image
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.network(
                coverImage,
                height: 160,
                width: 160,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 8),

            /// Playlist Name
            Text(
              playlistName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            /// Number of tracks inside playlist
            Text(
              "$trackCount songs",
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
