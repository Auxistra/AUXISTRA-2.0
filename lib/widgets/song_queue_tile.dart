import 'package:flutter/material.dart';

class SongQueueTile extends StatelessWidget {
  final String title;
  final String artist;
  final bool isPlaying;

  const SongQueueTile({
    super.key,
    required this.title,
    required this.artist,
    this.isPlaying = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        isPlaying ? Icons.equalizer : Icons.music_note,
        color: isPlaying ? const Color(0xFF1826F8) : Colors.white70,
      ),
      title: Text(title),
      subtitle: Text(artist),
      trailing: const Icon(Icons.drag_handle),
    );
  }
}
