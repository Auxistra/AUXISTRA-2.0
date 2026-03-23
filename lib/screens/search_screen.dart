import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/music_provider.dart';
import 'player_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final musicProvider = Provider.of<MusicProvider>(context);
    final activeColor = musicProvider.activeColor;

    return Scaffold(
      backgroundColor: Colors.transparent, // Made transparent for glass effect
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent, // Made transparent
            expandedHeight: 140,
            floating: true,
            pinned: true,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              title: const Text(
                'Search',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Column(
                children: [
                  TextField(
                    onChanged: (value) {
                      musicProvider.updateSearch(value);
                    },
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Artists, Songs, Lyrics...',
                      hintStyle: TextStyle(color: Colors.grey.shade600),
                      prefixIcon: Icon(Icons.search_rounded, color: activeColor),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.05), // Glass-like fill
                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: activeColor.withOpacity(0.1), width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: activeColor.withOpacity(0.5), width: 1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (musicProvider.searchedSongs.isEmpty)
            _buildBrowseGrid(activeColor)
          else
            _buildSearchResults(context, musicProvider),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }

  Widget _buildSearchResults(BuildContext context, MusicProvider provider) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final song = provider.searchedSongs[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.03),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              child: ListTile(
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
                contentPadding: const EdgeInsets.all(8),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: 56,
                    height: 56,
                    color: const Color(0xFF1C1C1E),
                    child: song.albumArt.isNotEmpty
                        ? Image.network(song.albumArt, fit: BoxFit.cover)
                        : const Icon(Icons.music_note, color: Colors.white10),
                  ),
                ),
                title: Text(
                  song.title,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                ),
                subtitle: Text(
                  song.artist,
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
                ),
                trailing: Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey.shade800, size: 16),
              ),
            );
          },
          childCount: provider.searchedSongs.length,
        ),
      ),
    );
  }

  Widget _buildBrowseGrid(Color activeColor) {
    final categories = ['Pop', 'Rock', 'Hip-Hop', 'Electronic', 'Jazz', 'Classical'];
    final colors = [
      const Color(0xFFE8115B),
      const Color(0xFF8D67AB),
      const Color(0xFF1E3264),
      const Color(0xFFF037A5),
      const Color(0xFF19E68C),
      const Color(0xFF27856A)
    ];

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.6,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [colors[index].withOpacity(0.5), colors[index].withOpacity(0.7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Text(
                categories[index],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
            );
          },
          childCount: categories.length,
        ),
      ),
    );
  }
}

