import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/music_provider.dart';
import 'player_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final musicProvider = Provider.of<MusicProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Text(
                'Search',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    musicProvider.searchSongs(value);
                  } else {
                    musicProvider.updateSearch('');
                  }
                },
                style: const TextStyle(fontSize: 17, color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Artists, Songs, Lyrics...',
                  hintStyle: TextStyle(color: Colors.grey.shade500),
                  prefixIcon: Icon(Icons.search, color: Colors.grey.shade400),
                  filled: true,
                  fillColor: const Color(0xFF1C1C1E),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: musicProvider.searchedSongs.isEmpty
                    ? _buildBrowseGrid(context)
                    : _buildSearchResults(context, musicProvider),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchResults(BuildContext context, MusicProvider provider) {
    return ListView.builder(
      itemCount: provider.searchedSongs.length,
      itemBuilder: (context, index) {
        final song = provider.searchedSongs[index];
        return ListTile(
          onTap: () {
            provider.playSong(song);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PlayerScreen(
                  songTitle: song.title,
                  artistName: song.artist,
                ),
              ),
            );
          },
          leading: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFF1C1C1E),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.music_note, color: Colors.white24),
          ),
          title: Text(song.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          subtitle: Text(song.artist, style: const TextStyle(color: Colors.grey)),
        );
      },
    );
  }

  Widget _buildBrowseGrid(BuildContext context) {
    final categories = ['Pop', 'Rock', 'Hip-Hop', 'Electronic', 'Jazz', 'Classical'];
    final colors = [Colors.purple, Colors.red, Colors.orange, Colors.blue, Colors.green, Colors.teal];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Browse All', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
        const SizedBox(height: 16),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              childAspectRatio: 1.6,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [colors[index].withOpacity(0.8), colors[index]],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    categories[index],
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
