import 'package:flutter/material.dart';

class RecentlyPlayedTile extends StatelessWidget {
  final String title;
  final String artist;

  const RecentlyPlayedTile({
    super.key,
    required this.title,
    required this.artist,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(6),
        ),
        child: const Icon(Icons.music_note, color: Colors.white),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        artist,
        style: const TextStyle(color: Colors.grey),
      ),
      trailing: const Icon(Icons.play_arrow, color: Colors.white),
    );
  }
}
