import 'package:flutter/material.dart';

/// ArtistHeader
/// Displays artist information such as profile picture,
/// followers, and action buttons like Follow or Play.
class ArtistHeader extends StatelessWidget {
  final String artistName;
  final String imageUrl;
  final int followers;
  final VoidCallback onFollow;
  final VoidCallback onPlay;

  const ArtistHeader({
    super.key,
    required this.artistName,
    required this.imageUrl,
    required this.followers,
    required this.onFollow,
    required this.onPlay,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Artist profile image
        CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage(imageUrl),
        ),

        const SizedBox(height: 12),

        /// Artist Name
        Text(
          artistName,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        /// Followers count
        Text(
          "$followers followers",
          style: const TextStyle(color: Colors.grey),
        ),

        const SizedBox(height: 12),

        /// Action buttons (Follow + Play)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: onFollow,
              child: const Text("Follow"),
            ),
            const SizedBox(width: 10),
            OutlinedButton(
              onPressed: onPlay,
              child: const Text("Play"),
            ),
          ],
        )
      ],
    );
  }
}
