import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import '../providers/music_provider.dart';
import '../models/music_models.dart';
import 'song_detail_screen_v2.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<MusicProvider>(context, listen: false);
    final songs = provider.recentSongs;
    int initialPage = 0;
    if (provider.currentSong != null) {
      initialPage = songs.indexWhere((s) => s.id == provider.currentSong!.id);
      if (initialPage == -1) initialPage = 0;
    }
    _currentPage = initialPage;
    _pageController = PageController(viewportFraction: 0.7, initialPage: initialPage);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final provider = Provider.of<MusicProvider>(context);
    final songs = provider.recentSongs;
    final activeColor = provider.activeColor;

    // Consistency: If activeColor changes elsewhere, we scroll to the matching song if needed
    if (provider.currentSong != null) {
      int targetPage = songs.indexWhere((s) => s.id == provider.currentSong!.id);
      if (targetPage != -1 && targetPage != _currentPage && _pageController.hasClients) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _pageController.jumpToPage(targetPage);
          setState(() => _currentPage = targetPage);
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              _buildSliverAppBar(activeColor),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionHeader('TRENDING NOW', activeColor),
                    _buildStylishCarousel(songs, provider, activeColor),
                    _buildSectionHeader('YOUR LIBRARY', activeColor),
                    _buildCompactList(songs, provider, activeColor),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(Color activeColor) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      expandedHeight: 120,
      floating: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          'AUXISTRA',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            letterSpacing: 6,
            fontSize: 22,
            shadows: [
              Shadow(color: activeColor.withOpacity(0.8), blurRadius: 15),
            ],
          ),
        ),
        centerTitle: true,
      ),
    );
  }

  Widget _buildSectionHeader(String title, Color activeColor) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
      child: Text(
        title,
        style: TextStyle(
          color: activeColor.withOpacity(0.9),
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildStylishCarousel(List<Song> songs, MusicProvider provider, Color activeColor) {
    if (songs.isEmpty) return const SizedBox(height: 300);

    return SizedBox(
      height: 420,
      child: PageView.builder(
        controller: _pageController,
        itemCount: songs.length,
        onPageChanged: (idx) => setState(() => _currentPage = idx),
        itemBuilder: (context, idx) {
          final song = songs[idx];
          double scale = math.max(0.8, 1 - (_currentPage - idx).abs() * 0.2);
          double angle = (_currentPage - idx) * 0.35;

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
            child: Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(angle),
              alignment: Alignment.center,
              child: _buildAlbumCard(song, scale, activeColor),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAlbumCard(Song song, double scale, Color activeColor) {
    bool isCurrent = scale > 0.9;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            width: 250 * scale,
            height: 250 * scale,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              image: song.albumArt.isNotEmpty
                  ? DecorationImage(image: NetworkImage(song.albumArt), fit: BoxFit.cover)
                  : null,
              color: const Color(0xFF1C1C1E),
              boxShadow: [
                BoxShadow(
                  color: (isCurrent ? activeColor : Colors.black).withOpacity(0.4),
                  blurRadius: 40,
                  spreadRadius: isCurrent ? 5 : 0,
                  offset: const Offset(0, 15),
                )
              ],
              border: isCurrent ? Border.all(color: activeColor.withOpacity(0.3), width: 2) : null,
            ),
            child: song.albumArt.isEmpty
                ? const Icon(Icons.music_note, size: 80, color: Colors.white10)
                : null,
          ),
          const SizedBox(height: 32),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: isCurrent ? 1.0 : 0.3,
            child: Column(
              children: [
                Text(
                  song.title.toUpperCase(),
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20, letterSpacing: 1.5),
                ),
                const SizedBox(height: 4),
                Text(
                  song.artist,
                  style: TextStyle(color: activeColor.withOpacity(0.7), fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactList(List<Song> songs, MusicProvider provider, Color activeColor) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: songs.length,
      itemBuilder: (context, idx) {
        final song = songs[idx];
        bool isPlaying = provider.currentSong?.id == song.id;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: isPlaying ? activeColor.withOpacity(0.1) : Colors.white.withOpacity(0.03),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: isPlaying ? activeColor.withOpacity(0.3) : Colors.white.withOpacity(0.05)),
          ),
          child: ListTile(
            onTap: () {
              provider.playSong(song);
              _pageController.animateToPage(idx, duration: const Duration(milliseconds: 600), curve: Curves.elasticOut);
            },
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: 54,
                height: 54,
                color: const Color(0xFF1C1C1E),
                child: song.albumArt.isNotEmpty
                  ? Image.network(song.albumArt, fit: BoxFit.cover)
                  : const Icon(Icons.music_note, color: Colors.white10),
              ),
            ),
            title: Text(
              song.title,
              style: TextStyle(
                color: isPlaying ? Colors.white : Colors.white.withOpacity(0.9),
                fontWeight: isPlaying ? FontWeight.bold : FontWeight.w500
              )
            ),
            subtitle: Text(song.artist, style: TextStyle(color: isPlaying ? activeColor.withOpacity(0.8) : Colors.grey, fontSize: 13)),
            trailing: isPlaying
              ? Icon(Icons.graphic_eq, color: activeColor)
              : const Icon(Icons.play_arrow_rounded, color: Colors.white24),
          ),
        );
      },
    );
  }
}
