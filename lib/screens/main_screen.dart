import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import '../providers/music_provider.dart';
import 'home_screen.dart';
import 'search_screen.dart';
import 'library_screen.dart';
import 'artist_screen.dart';
import 'song_detail_screen_v2.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _screens = <Widget>[
    HomeScreen(),
    SearchScreen(),
    LibraryScreen(),
    ArtistScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MusicProvider>(context);
    final activeColor = provider.activeColor;
    final currentSong = provider.currentSong;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. LIQUID GLASS BACKGROUND SOURCE (The Album Art)
          if (currentSong != null && currentSong.albumArt.isNotEmpty)
            Positioned.fill(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 1000),
                child: Image.network(
                  currentSong.albumArt,
                  key: ValueKey(currentSong.id),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),

          // 2. CONSISTENT GLASS CLARITY LAYER (BackdropFilter)
          // Using a lower sigma (15) for higher clarity as requested
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.1),
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // 3. AMBIENT THEME BLOOM (Always matches active song)
          AnimatedContainer(
            duration: const Duration(seconds: 1),
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(0.0, -0.5),
                radius: 1.5,
                colors: [
                  activeColor.withOpacity(0.15),
                  Colors.transparent,
                ],
              ),
            ),
          ),

          // 4. CORE CONTENT
          IndexedStack(
            index: _selectedIndex,
            children: _screens,
          ),

          // 5. MINI PLAYER
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildStylishMiniPlayer(context, provider, activeColor),
          ),
        ],
      ),
      bottomNavigationBar: _buildStylishNavBar(activeColor),
    );
  }

  Widget _buildStylishNavBar(Color activeColor) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        border: Border(top: BorderSide(color: activeColor.withOpacity(0.2), width: 0.5)),
      ),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: (idx) => setState(() => _selectedIndex = idx),
            selectedItemColor: activeColor,
            unselectedItemColor: Colors.white.withOpacity(0.3),
            backgroundColor: Colors.transparent,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.search_rounded), label: 'Search'),
              BottomNavigationBarItem(icon: Icon(Icons.library_music_rounded), label: 'Library'),
              BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Artist'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStylishMiniPlayer(BuildContext context, MusicProvider provider, Color activeColor) {
    final song = provider.currentSong;
    if (song == null) return const SizedBox.shrink();

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, anim, _) => SongDetailScreenV2(
              songId: song.id,
              songTitle: song.title,
              artistName: song.artist,
            ),
            transitionsBuilder: (context, anim, _, child) => FadeTransition(opacity: anim, child: child),
          ),
        );
      },
      child: Container(
        height: 76,
        margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: activeColor.withOpacity(0.3)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Hero(
                    tag: 'art_${song.id}',
                    child: Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: song.albumArt.isNotEmpty
                            ? DecorationImage(image: NetworkImage(song.albumArt), fit: BoxFit.cover)
                            : null,
                        color: Colors.black,
                        border: Border.all(color: activeColor.withOpacity(0.5), width: 1.5),
                        boxShadow: [
                          BoxShadow(color: activeColor.withOpacity(0.3), blurRadius: 10)
                        ],
                      ),
                      child: song.albumArt.isEmpty
                          ? const Icon(Icons.music_note, color: Colors.white24)
                          : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          song.title,
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          song.artist,
                          style: TextStyle(color: activeColor.withOpacity(0.9), fontSize: 12, fontWeight: FontWeight.w600),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      provider.isPlaying ? Icons.pause_circle_filled_rounded : Icons.play_circle_filled_rounded,
                      color: activeColor, // Changed from white to activeColor for theme consistency
                      size: 40,
                    ),
                    onPressed: () => provider.togglePlay(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
