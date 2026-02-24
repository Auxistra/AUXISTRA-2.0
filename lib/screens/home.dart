import 'package:flutter/material.dart';
import 'player_screen.dart';

/// --------------------
/// Song Model
/// --------------------
class Song {
  final String title;
  final String artist;

  const Song({
    required this.title,
    required this.artist,
  });
}

/// --------------------
/// Home Screen
/// --------------------
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Dummy Song Data (Replace later with API/DB)
  static const List<Song> songs = [
    Song(title: 'Midnight Echo', artist: 'Neon Wave'),
    Song(title: 'Lost in Light', artist: 'Aurora Sky'),
    Song(title: 'Dream Runner', artist: 'Pulse Drive'),
    Song(title: 'Neon City', artist: 'Starfield'),
    Song(title: 'Ocean Beats', artist: 'Blue Wave'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: Colors.black,
      body: ListView(
        padding: const EdgeInsets.only(bottom: 16),
        children: [
          _buildSection('Listen Now'),
          _buildSection('Recently Played'),
          _buildSection('Made for You'),
        ],
      ),
    );
  }

  /// --------------------
  /// AppBar
  /// --------------------
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text(
        'Home',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 26,
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        IconButton(
          icon: const CircleAvatar(
            backgroundColor: Colors.grey,
            child: Icon(Icons.person, color: Colors.white),
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  /// --------------------
  /// Section Builder
  /// --------------------
  Widget _buildSection(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(title),
        SongHorizontalList(songs: songs),
      ],
    );
  }

  /// --------------------
  /// Section Title
  /// --------------------
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}

/// --------------------
/// Horizontal Song List
/// --------------------
class SongHorizontalList extends StatelessWidget {
  final List<Song> songs;

  const SongHorizontalList({
    super.key,
    required this.songs,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: songs.length,
        itemBuilder: (context, index) {
          return SongCard(song: songs[index]);
        },
      ),
    );
  }
}

/// --------------------
/// Song Card Widget
/// --------------------
class SongCard extends StatelessWidget {
  final Song song;

  const SongCard({
    super.key,
    required this.song,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PlayerScreen(
              songTitle: song.title,
              artistName: song.artist,
            ),
          ),
        );
      },
      child: Container(
        width: 160,
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: const Color(0xFF2C2C2C),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCover(),
            _buildInfo(),
          ],
        ),
      ),
    );
  }

  /// Album Cover Placeholder
  Widget _buildCover() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(10),
          ),
        ),
        child: const Center(
          child: Icon(
            Icons.music_note,
            size: 48,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  /// Song Info
  Widget _buildInfo() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            song.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            song.artist,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
