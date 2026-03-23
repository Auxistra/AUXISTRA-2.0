import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/music_provider.dart';
import 'song_detail_screen_v2.dart';
import 'stem_settings_screen.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MusicProvider>(context);
    final songs = provider.recentSongs;
    final activeColor = provider.activeColor;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
        slivers: [
          /// ===== APP BAR =====
          SliverAppBar(
            backgroundColor: Colors.transparent,
            expandedHeight: 120,
            floating: true,
            pinned: true,
            elevation: 0,
            flexibleSpace: const FlexibleSpaceBar(
              titlePadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              title: Text(
                'Library',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 28,
                  color: Colors.white,
                ),
              ),
            ),
            actions: [
              TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const StemSettingsScreen(),
                    ),
                  );
                },
                icon: Icon(Icons.tune_rounded, color: activeColor),
                label: Text(
                  'Stems',
                  style: TextStyle(color: activeColor),
                ),
              ),
            ],
          ),

          /// ===== LIBRARY OPTIONS =====
          SliverList(
            delegate: SliverChildListDelegate([
              _buildLibraryItem(context, Icons.playlist_play, 'Playlists', activeColor),
              _buildLibraryItem(context, Icons.music_note, 'Songs', activeColor),
              _buildLibraryItem(context, Icons.album, 'Albums', activeColor),
              _buildLibraryItem(context, Icons.person, 'Artists', activeColor),
              _buildLibraryItem(context, Icons.download, 'Downloaded', activeColor),

              const SizedBox(height: 20),

              /// SECTION TITLE
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Recently Played',
                  style: TextStyle(
                    color: activeColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ]),
          ),

          /// ===== SONG GRID =====
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.75,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final song = songs[index];
                  final isPlaying = provider.currentSong?.id == song.id;

                  return GestureDetector(
                    onTap: () {
                      provider.playSong(song);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SongDetailScreenV2(
                            songId: song.id,
                            songTitle: song.title,
                            artistName: song.artist,
                          ),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Album Cover
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              image: song.albumArt.isNotEmpty
                                  ? DecorationImage(
                                      image: NetworkImage(song.albumArt),
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                              color: Colors.grey[900],
                              border: Border.all(
                                color: isPlaying ? activeColor : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: song.albumArt.isEmpty
                                ? const Icon(Icons.music_note, color: Colors.white24)
                                : null,
                          ),
                        ),

                        const SizedBox(height: 8),

                        /// Song Title
                        Text(
                          song.title,
                          style: TextStyle(
                            color: isPlaying ? activeColor : Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),

                        /// Artist Name
                        Text(
                          song.artist,
                          style: const TextStyle(color: Colors.grey),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  );
                },
                childCount: songs.length,
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      ),
    );
  }

  /// ===== LIBRARY ITEM BUILDER =====
  Widget _buildLibraryItem(
    BuildContext context,
    IconData icon,
    String title,
    Color activeColor,
  ) {
    return ListTile(
      leading: Icon(icon, color: activeColor),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: () {},
    );
  }
}