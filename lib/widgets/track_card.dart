import 'package:flutter/material.dart';

/// A reusable card widget that represents a music track.
/// Used in Home, Search results, and Library lists.
class TrackCard extends StatelessWidget {
  final String title;
  final String artist;
  final String coverUrl;
  final VoidCallback onPlay;

  const TrackCard({
    super.key,
    required this.title,
    required this.artist,
    required this.coverUrl,
    required this.onPlay,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            coverUrl,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(artist),
        trailing: IconButton(
          icon: const Icon(Icons.play_circle_fill),
          onPressed: onPlay, // Trigger play action
        ),
      ),
    );
  }
}
