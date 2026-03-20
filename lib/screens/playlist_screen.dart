import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/music_provider.dart';
import '../models/music_models.dart';
import 'player_screen.dart';

class PlaylistScreen extends StatelessWidget {
  const PlaylistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final musicProvider = Provider.of<MusicProvider>(context);
    // For production, we would fetch a specific playlist.
    // Here we use the 'recentSongs' list as a dynamic placeholder.
    final List<Song> playlistTracks = musicProvider.recentSongs;

    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildAppBar(context),
          _buildPlaylistHeader(context),
          _buildActionButtons(context),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final song = playlistTracks[index];
                return _buildTrackTile(context, song, musicProvider);
              },
              childCount: playlistTracks.length,
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return const SliverAppBar(
      backgroundColor: Colors.black,
      elevation: 0,
      pinned: true,
      title: Text('Playlist', style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildPlaylistHeader(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          const SizedBox(height: 20),
          Center(
            child: Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                color: const Color(0xFF1C1C1E),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF1826F8).withOpacity(0.2),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  )
                ],
              ),
              child: const Icon(Icons.music_note, size: 80, color: Colors.white10),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Late Night Mix',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            'Curated for your midnight sessions',
            style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.play_arrow_rounded, color: Colors.black, size: 28),
                label: const Text('Play', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.shuffle, color: Colors.white, size: 24),
                label: const Text('Shuffle', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1C1C1E),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrackTile(BuildContext context, Song song, MusicProvider provider) {
    final bool isCurrent = provider.currentSong?.id == song.id;

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
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: const Color(0xFF1C1C1E),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          isCurrent ? Icons.graphic_eq : Icons.music_note,
          color: isCurrent ? const Color(0xFF1826F8) : Colors.white24,
        ),
      ),
      title: Text(
        song.title,
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: isCurrent ? const Color(0xFF1826F8) : Colors.white,
        ),
      ),
      subtitle: Text(song.artist, style: TextStyle(color: Colors.grey.shade500)),
      trailing: const Icon(Icons.more_vert, color: Colors.grey),
    );
  }
}
