import 'package:flutter/material.dart';

/// AlbumHeader displays the main information of an album
/// at the top of an Album Details screen.
///
/// This typically includes:
/// - Album artwork
/// - Album title
/// - Artist name
/// - Release year
/// - Play button
class AlbumHeader extends StatelessWidget {
  /// Album artwork URL
  final String? coverUrl;

  /// Album title
  final String title;

  /// Artist name
  final String artist;

  /// Release year of the album
  final String year;

  /// Callback when play button is pressed
  final VoidCallback? onPlay;

  const AlbumHeader({
    super.key,
    required this.title,
    required this.artist,
    required this.year,
    this.coverUrl,
    this.onPlay,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Album artwork
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: coverUrl != null
              ? Image.network(
                  coverUrl!,
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                )
              : Container(
                  height: 200,
                  width: 200,
                  color: const Color(0xFF2C2C2C),
                  child: const Icon(Icons.album, size: 80, color: Colors.white),
                ),
        ),

        const SizedBox(height: 16),

        /// Album title
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        /// Artist name
        Text(
          artist,
          style: const TextStyle(color: Colors.grey),
        ),

        /// Release year
        Text(
          year,
          style: const TextStyle(color: Colors.grey),
        ),

        const SizedBox(height: 12),

        /// Play album button
        ElevatedButton.icon(
          onPressed: onPlay,
          icon: const Icon(Icons.play_arrow),
          label: const Text("Play Album"),
        )
      ],
    );
  }
}
