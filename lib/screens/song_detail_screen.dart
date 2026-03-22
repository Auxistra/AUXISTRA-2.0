
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/music_provider.dart';

class SongDetailScreen extends StatefulWidget {
  final String songId;
  final String songTitle;
  final String artistName;

  const SongDetailScreen({
    super.key,
    required this.songId,
    required this.songTitle,
    required this.artistName,
  });

  @override
  State<SongDetailScreen> createState() => _SongDetailScreenState();
}

class _SongDetailScreenState extends State<SongDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MusicProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 30),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  provider.isRemixing ? Icons.close : Icons.tune,
                  color: const Color(0xFF1826F8),
                  size: 28,
                ),
                onPressed: () => provider.toggleRemixMode(!provider.isRemixing),
              ),
              const SizedBox(width: 8),
            ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: provider.isRemixing
                      ? _buildRemixEditor(provider)
                      : _buildStandardPlayer(provider),
                ),
                _buildPlaybackControls(provider),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStandardPlayer(MusicProvider provider) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          width: provider.isPlaying ? 280 : 260,
          height: provider.isPlaying ? 280 : 260,
          decoration: BoxDecoration(
            color: const Color(0xFF1C1C1E),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF1826F8).withOpacity(provider.isPlaying ? 0.4 : 0.1),
                blurRadius: 40,
              )
            ],
          ),
          child: const Icon(Icons.music_note, size: 100, color: Colors.white10),
        ),
        const SizedBox(height: 48),
        Text(widget.songTitle, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white)),
        const SizedBox(height: 8),
        Text(widget.artistName, style: const TextStyle(fontSize: 18, color: Colors.grey)),
      ],
    );
  }

  Widget _buildRemixEditor(MusicProvider provider) {
    // Generic labels matching the Provider
    final stemNames = ['Stem 1', 'Stem 2', 'Stem 3', 'Stem 4'];

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      children: [
        const Text('Stem Remixing', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
        const SizedBox(height: 24),
        ...stemNames.map((name) => _buildTrackItem(name, provider)),
      ],
    );
  }

  Widget _buildTrackItem(String name, MusicProvider provider) {
    final double volume = provider.currentSong?.stemVolumes[name] ?? 1.0;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: const Color(0xFF1C1C1E), borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          SizedBox(width: 60, child: Text(name, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 13))),
          Expanded(
            child: Slider(
              value: volume,
              onChanged: (v) => provider.updateStemVolume(name, v),
              activeColor: const Color(0xFF1826F8),
            ),
          ),
          IconButton(
            icon: Icon(volume > 0 ? Icons.volume_up : Icons.volume_off, color: Colors.white70, size: 18),
            onPressed: () => provider.updateStemVolume(name, volume > 0 ? 0.0 : 1.0),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaybackControls(MusicProvider provider) {
    String format(Duration d) => "${d.inMinutes}:${(d.inSeconds % 60).toString().padLeft(2, '0')}";

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
      child: Column(
        children: [
          Slider(
            value: provider.position.inMilliseconds.toDouble().clamp(0.0, provider.duration.inMilliseconds.toDouble() > 0 ? provider.duration.inMilliseconds.toDouble() : 1.0),
            max: provider.duration.inMilliseconds.toDouble() > 0 ? provider.duration.inMilliseconds.toDouble() : 1.0,
            onChanged: (v) => provider.seek(Duration(milliseconds: v.toInt())),
            activeColor: const Color(0xFF1826F8),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(format(provider.position), style: const TextStyle(fontSize: 12, color: Colors.grey)),
                Text(format(provider.duration), style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Icon(Icons.shuffle, color: Colors.grey),
              IconButton(icon: const Icon(Icons.skip_previous, size: 36, color: Colors.white), onPressed: () {}),
              GestureDetector(
                onTap: () => provider.togglePlay(),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                  child: Icon(provider.isPlaying ? Icons.pause : Icons.play_arrow, size: 42, color: Colors.black),
                ),
              ),
              IconButton(icon: const Icon(Icons.skip_next, size: 36, color: Colors.white), onPressed: () {}),
              const Icon(Icons.repeat, color: Colors.grey),
            ],
          ),
        ],
      ),
    );
  }
}
