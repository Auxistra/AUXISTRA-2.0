import 'package:flutter/material.dart';

/// A reusable widget that represents a single song item in a list.
/// This widget is designed for:
/// - Library screens
/// - Playlist screens
/// - Search results
/// - Queue lists
class SongTile extends StatelessWidget {
  /// Title of the song
  final String title;

  /// Name of the artist
  final String artist;

  /// Duration of the song (example: 3:42)
  final String duration;

  /// Optional album artwork
  final String? coverUrl;

  /// Callback when the user taps the song
  final VoidCallback? onTap;

  const SongTile({
    super.key,
    required this.title,
    required this.artist,
    required this.duration,
    this.coverUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      /// Song cover image
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: coverUrl != null
            ? Image.network(
                coverUrl!,
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

      /// Song title
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),

      /// Artist name
      subtitle: Text(artist),

      /// Song duration displayed on the right
      trailing: Text(duration),

      /// When user taps the tile
      onTap: onTap,
    );
  }
}
