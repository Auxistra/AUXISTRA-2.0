import 'package:flutter/material.dart';

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
  bool _isPlaying = false;

  double _playbackPosition = 0.3;

  // Track volume state (instead of static values)
  final Map<String, double> _trackVolumes = {
    'Vocals': 0.8,
    'Drums': 0.6,
    'Bass': 0.7,
    'Synths': 0.4,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_down),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isRemixMode ? Icons.close : Icons.tune,
              color: const Color(0xFF1826F8),
            ),
            onPressed: () => setState(() {
              _isRemixMode = !_isRemixMode;
            }),
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

  // ---------------- STANDARD PLAYER ----------------

  Widget _buildStandardPlayer() {
    return Column(
      key: const ValueKey("standard"),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 280,
          height: 280,
          decoration: BoxDecoration(
            color: const Color(0xFF2C2C2C),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF1826F8)
                    .withOpacity(_isPlaying ? 0.6 : 0.3),
                blurRadius: _isPlaying ? 30 : 15,
                spreadRadius: 4,
              )
            ],
          ),
          child: const Icon(Icons.music_note,
              size: 100, color: Colors.white),
        ),
        const SizedBox(height: 40),
        Text(
          widget.songTitle,
          style: const TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Text(
          widget.artistName,
          style: const TextStyle(
              fontSize: 18, color: Colors.grey),
        ),
      ],
    );
  }

  // ---------------- REMIX EDITOR ----------------

  Widget _buildRemixEditor() {
    return Container(
      key: const ValueKey("remix"),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'DAW - Remix Session',
            style:
                TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: _trackVolumes.keys.map((track) {
                return _buildTrackItem(
                  track,
                  _trackVolumes[track]!,
                );
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
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(10),
        border:
            Border.all(color: trackColor.withOpacity(0.4)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(width: 4, height: 40, color: trackColor),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.volume_off, size: 20),
                onPressed: () {
                  setState(() {
                    _trackVolumes[name] =
                        _trackVolumes[name]! > 0 ? 0 : 0.7;
                  });
                },
              ),
            ],
          ),
          Slider(
            value: volume,
            onChanged: (v) {
              setState(() {
                _trackVolumes[name] = v;
              });
            },
            activeColor: trackColor,
            inactiveColor: Colors.grey[800],
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

  // ---------------- DAW TOOLBAR ----------------

  Widget _buildDawToolbar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
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
        Icon(icon, size: 24, color: const Color(0xFF1826F8)),
        const SizedBox(height: 4),
        Text(label,
            style: const TextStyle(
                fontSize: 10, color: Colors.grey)),
      ],
    );
  }

  // ---------------- PLAYBACK CONTROLS ----------------

  Widget _buildPlaybackControls() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Slider(
            value: _playbackPosition,
            onChanged: (v) =>
                setState(() => _playbackPosition = v),
            activeColor: const Color(0xFF1826F8),
          ),
          const Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Text('1:02',
                  style:
                      TextStyle(fontSize: 12, color: Colors.grey)),
              Text('3:45',
                  style:
                      TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  icon: const Icon(Icons.shuffle,
                      color: Colors.grey),
                  onPressed: () {}),
              IconButton(
                  icon:
                      const Icon(Icons.skip_previous, size: 40),
                  onPressed: () {}),
              Container(
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white),
                child: IconButton(
                  icon: Icon(
                    _isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                    size: 48,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPlaying = !_isPlaying;
                    });
                  },
                ),
              ),
              IconButton(
                  icon:
                      const Icon(Icons.skip_next, size: 40),
                  onPressed: () {}),
              IconButton(
                  icon:
                      const Icon(Icons.repeat, color: Colors.grey),
                  onPressed: () {}),
            ],
          ),
        ],
      ),
    );
  }
}
