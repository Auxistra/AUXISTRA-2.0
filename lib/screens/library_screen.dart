import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
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
      backgroundColor: Colors.transparent, // Transparent for glass effect
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            expandedHeight: 120,
            floating: true,
            pinned: true,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              title: const Text(
                'Library',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 28,
                  color: Colors.white,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const StemSettingsScreen()),
                    );
                  },
                  icon: Icon(Icons.tune_rounded, color: activeColor, size: 20),
                  label: Text(
                    'Stems',
                    style: TextStyle(color: activeColor, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 10),
              _buildLibraryItem(context, Icons.playlist_play_rounded, 'Playlists', activeColor),
              _buildLibraryItem(context, Icons.music_note_rounded, 'Songs', activeColor),
              _buildLibraryItem(context, Icons.album_rounded, 'Albums', activeColor),
              _buildLibraryItem(context, Icons.person_rounded, 'Artists', activeColor),
              _buildLibraryItem(context, Icons.download_done_rounded, 'Downloaded', activeColor),

              Padding(
                padding: const EdgeInsets.fromLTRB(20, 32, 20, 16),
                child: Row(
                  children: [
                    Text(
                      'UPLOADS',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: activeColor.withOpacity(0.8),
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(child: Divider(color: activeColor.withOpacity(0.2), thickness: 0.5)),
                  ],
                ),
              ),
            ]),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 14,
                mainAxisSpacing: 24,
                childAspectRatio: 0.68,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final song = songs[index];
                  bool isPlaying = provider.currentSong?.id == song.id;

                  return GestureDetector(
                    onTap: () {
                      provider.playSong(song);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SongDetailScreenV2(
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
                        Expanded(
                          child: Stack(
                            children: [
                              Hero(
                                tag: 'lib_art_${song.id}',
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      image: song.albumArt.isNotEmpty
                                          ? DecorationImage(
                                              image: NetworkImage(song.albumArt),
                                              fit: BoxFit.cover,
                                            )
                                          : null,
                                      color: Colors.white.withOpacity(0.05),
                                      border: Border.all(
                                        color: isPlaying ? activeColor.withOpacity(0.5) : Colors.white.withOpacity(0.1),
                                        width: isPlaying ? 2 : 1,
                                      ),
                                    ),
                                    child: song.albumArt.isEmpty
                                        ? const Center(child: Icon(Icons.music_note, color: Colors.white10, size: 32))
                                        : null,
                                  ),
                                ),
                              ),
                              if (isPlaying)
                                Positioned(
                                  right: 8,
                                  bottom: 8,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.7),
                                      shape: BoxShape.circle,
                                      border: Border.all(color: activeColor.withOpacity(0.5), width: 0.5),
                                    ),
                                    child: Icon(Icons.graphic_eq_rounded, color: activeColor, size: 12),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          song.title,
                          style: TextStyle(
                            color: isPlaying ? activeColor : Colors.white.withOpacity(0.9),
                            fontWeight: isPlaying ? FontWeight.bold : FontWeight.w600,
                            fontSize: 13,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          song.artist,
                          style: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 11,
                          ),
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
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }

  Widget _buildLibraryItem(BuildContext context, IconData icon, String title, Color activeColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: activeColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: activeColor, size: 24),
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: const TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.w500),
              ),
              const Spacer(),
              Icon(Icons.chevron_right_rounded, size: 20, color: Colors.white.withOpacity(0.2)),
            ],
          ),
        ),
      ),
    );
  }
}
