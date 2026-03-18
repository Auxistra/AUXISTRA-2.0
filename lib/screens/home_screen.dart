import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/music_provider.dart';
import '../models/music_models.dart';
import 'song_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final musicProvider = Provider.of<MusicProvider>(context);
    print('HomeScreen build - songs count: ${musicProvider.recentSongs.length}'); // Debug print

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Listen Now',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32, color: Colors.white),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Trending Now'),
            _buildHorizontalList(context, musicProvider.recentSongs, musicProvider),
            _buildSectionTitle('Recommended'),
            _buildHorizontalList(context, musicProvider.recentSongs, musicProvider, isLarge: true),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 32, 20, 16),
      child: Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
    );
  }

  Widget _buildHorizontalList(BuildContext context, List<Song> songs, MusicProvider provider, {bool isLarge = false}) {
    final size = isLarge ? 220.0 : 160.0;
    return SizedBox(
      height: size + 70,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: songs.length,
        itemBuilder: (context, index) {
          final song = songs[index];
          return GestureDetector(
            onTap: () {
              provider.playSong(song);
              print('Navigating to song: ${song.title} (ID: ${song.id})'); // Debug print
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SongDetailScreen(
                    songId: song.id,
                    songTitle: song.title,
                    artistName: song.artist,
                  ),
                ),
              );
            },
            child: Container(
              width: size,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1C1C1E),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 10, offset: const Offset(0, 6))],
                    ),
                    child: const Center(child: Icon(Icons.music_note, size: 64, color: Colors.white10)),
                  ),
                  const SizedBox(height: 12),
                  Text(song.title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16), maxLines: 1),
                  Text(song.artist, style: TextStyle(color: Colors.grey.shade500, fontSize: 14), maxLines: 1),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
