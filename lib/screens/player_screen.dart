import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:just_audio/just_audio.dart';
import '../providers/music_provider.dart';

class PlayerScreen extends StatefulWidget {
  final String songTitle;
  final String artistName;

  const PlayerScreen({
    super.key,
    required this.songTitle,
    required this.artistName,
  });

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  bool _isRemixMode = false;

  final Map<String, double> _trackVolumes = {
    'Vocals': 0.8,
    'Drums': 0.6,
    'Bass': 0.7,
    'Synths': 0.4,
  };

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    final musicProvider = Provider.of<MusicProvider>(context);

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
              _isRemixMode ? Icons.close : Icons.tune,
              color: const Color(0xFF1826F8),
              size: 28,
            ),
            onPressed: () => setState(() => _isRemixMode = !_isRemixMode),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _isRemixMode ? _buildRemixEditor() : _buildStandardPlayer(musicProvider),
            ),
            _buildPlaybackControls(musicProvider),
          ],
        ),
      ),
    );
  }

  Widget _buildStandardPlayer(MusicProvider provider) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Dynamically calculate artwork size: 60% of available height, max 280
        final double artworkSize = (constraints.maxHeight * 0.6).clamp(180.0, 280.0);

        return SingleChildScrollView(
          child: Column(
            key: const ValueKey("standard"),
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                width: provider.isPlaying ? artworkSize : artworkSize * 0.9,
                height: provider.isPlaying ? artworkSize : artworkSize * 0.9,
                decoration: BoxDecoration(
                  color: const Color(0xFF1C1C1E),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF1826F8).withOpacity(provider.isPlaying ? 0.4 : 0.1),
                      blurRadius: provider.isPlaying ? 40 : 10,
                    )
                  ],
                ),
                child: Icon(Icons.music_note, size: artworkSize * 0.4, color: Colors.white10),
              ),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.songTitle,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.artistName,
                      style: const TextStyle(fontSize: 18, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRemixEditor() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      children: [
        const Text('Stem Mixer', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
        const SizedBox(height: 16),
        ..._trackVolumes.keys.map((track) => _buildTrackItem(track, _trackVolumes[track]!)),
      ],
    );
  }

  Widget _buildTrackItem(String name, double volume) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: const Color(0xFF1C1C1E), borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Text(name, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          const Spacer(),
          Slider(
            value: volume,
            activeColor: const Color(0xFF1826F8),
            onChanged: (v) => setState(() => _trackVolumes[name] = v),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaybackControls(MusicProvider provider) {
    final position = provider.position;
    final duration = provider.duration;

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Slider(
            value: position.inMilliseconds.toDouble().clamp(0.0, duration.inMilliseconds.toDouble() > 0 ? duration.inMilliseconds.toDouble() : 1.0),
            max: duration.inMilliseconds.toDouble() > 0 ? duration.inMilliseconds.toDouble() : 1.0,
            onChanged: (v) => provider.seek(Duration(milliseconds: v.toInt())),
            activeColor: const Color(0xFF1826F8),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_formatDuration(position), style: const TextStyle(fontSize: 12, color: Colors.grey)),
                Text(_formatDuration(duration), style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          const SizedBox(height: 20),
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
