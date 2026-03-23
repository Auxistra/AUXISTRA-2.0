
import 'package:flutter/material.dart';

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
  bool _isRemixMode = false;
  bool _isPlaying = true;
  double _playbackPosition = 0.3;

  final Map<String, double> _trackVolumes = {
    'Vocals': 0.8,
    'Drums': 0.6,
    'Bass': 0.7,
    'Synths': 0.4,
  };

  @override
  Widget build(BuildContext context) {
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
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
              tooltip: 'Stem Remixing',
              icon: Icon(
                _isRemixMode ? Icons.close : Icons.tune,
                color: const Color(0xFF1826F8),
                size: 28,
              ),
              onPressed: () => setState(() {
                _isRemixMode = !_isRemixMode;
              }),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              transitionBuilder: (child, animation) =>
                  FadeTransition(opacity: animation, child: child),
              child: _isRemixMode
                  ? _buildRemixEditor()
                  : _buildStandardPlayer(),
            ),
          ),
          _buildPlaybackControls(),
        ],
      ),
    );
  }

  Widget _buildStandardPlayer() {
    return Column(
      key: const ValueKey("standard"),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 320,
          height: 320,
          decoration: BoxDecoration(
            color: const Color(0xFF1C1C1E),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF1826F8).withOpacity(_isPlaying ? 0.6 : 0.2),
                blurRadius: _isPlaying ? 40 : 20,
                spreadRadius: 4,
              )
            ],
          ),
          child: const Center(
            child: Icon(Icons.music_note, size: 120, color: Colors.white10),
          ),
        ),
        const SizedBox(height: 64),
        Text(
          widget.songTitle,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          widget.artistName,
          style: TextStyle(
            fontSize: 20,
            color: Colors.grey.shade400,
          ),
        ),
      ],
    );
  }

  Widget _buildRemixEditor() {
    return Container(
      key: const ValueKey("remix"),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Stem Mixer',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            'Adjust individual track levels',
            style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: _trackVolumes.keys.map((track) {
                return _buildTrackItem(track, _trackVolumes[track]!);
              }).toList(),
            ),
          ),
          _buildDawToolbar(),
        ],
      ),
    );
  }

  Widget _buildTrackItem(String name, double volume) {
    final Color trackColor = _getTrackColor(name);
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: trackColor.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(width: 4, height: 40, color: trackColor),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
                ),
              ),
              IconButton(
                icon: Icon(volume > 0 ? Icons.volume_up : Icons.volume_off, color: Colors.white70, size: 24),
                onPressed: () {
                  setState(() {
                    _trackVolumes[name] = _trackVolumes[name]! > 0 ? 0 : 0.8;
                  });
                },
              ),
            ],
          ),
          Slider(
            value: volume,
            onChanged: (v) => setState(() => _trackVolumes[name] = v),
            activeColor: trackColor,
            inactiveColor: Colors.grey.shade800,
          ),
        ],
      ),
    );
  }

  Color _getTrackColor(String name) {
    switch (name) {
      case 'Vocals':
        return Colors.blue;
      case 'Drums':
        return Colors.orange;
      case 'Bass':
        return Colors.purple;
      default:
        return Colors.green;
    }
  }

  Widget _buildDawToolbar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _toolbarIcon(Icons.history, 'History'),
          _toolbarIcon(Icons.content_copy, 'Clips'),
          _toolbarIcon(Icons.graphic_eq, 'FX'),
          _toolbarIcon(Icons.save, 'Export'),
        ],
      ),
    );
  }

  Widget _toolbarIcon(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, size: 28, color: const Color(0xFF1826F8)),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  Widget _buildPlaybackControls() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
      child: Column(
        children: [
          Slider(
            value: _playbackPosition,
            onChanged: (v) => setState(() => _playbackPosition = v),
            activeColor: const Color(0xFF1826F8),
            inactiveColor: Colors.grey.shade800,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('1:02', style: TextStyle(fontSize: 14, color: Colors.grey)),
                Text('3:45', style: TextStyle(fontSize: 14, color: Colors.grey)),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(icon: const Icon(Icons.shuffle, color: Colors.white, size: 28), onPressed: () {}),
              IconButton(icon: const Icon(Icons.skip_previous, size: 48, color: Colors.white), onPressed: () {}),
              Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                child: IconButton(
                  icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow, size: 48, color: Colors.black),
                  onPressed: () => setState(() => _isPlaying = !_isPlaying),
                ),
              ),
              IconButton(icon: const Icon(Icons.skip_next, size: 48, color: Colors.white), onPressed: () {}),
              IconButton(icon: const Icon(Icons.repeat, color: Colors.white, size: 28), onPressed: () {}),
            ],
          ),
        ],
      ),
    );
  }
}

