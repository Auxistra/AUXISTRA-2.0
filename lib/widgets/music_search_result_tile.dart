import 'package:flutter/material.dart';

/// MusicSearchResultTile is used to display search results
/// when users search for songs, artists, or albums.
///
/// It shows:
/// - Song/artist image
/// - Title
/// - Artist name
class MusicSearchResultTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? imageUrl;
  final VoidCallback? onTap;

  const MusicSearchResultTile({
    super.key,
    required this.title,
    required this.subtitle,
    this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      /// Leading image for the result
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: imageUrl != null
            ? Image.network(
                imageUrl!,
                width: 48,
                height: 48,
                fit: BoxFit.cover,
              )
            : Container(
                width: 48,
                height: 48,
                color: const Color(0xFF2C2C2C),
                child: const Icon(Icons.music_note, color: Colors.white),
              ),
      ),

      /// Main title (song or album name)
      title: Text(title),

      /// Secondary text (artist name)
      subtitle: Text(subtitle),

      /// Trigger action when tapped
      onTap: onTap,
    );
  }
}
