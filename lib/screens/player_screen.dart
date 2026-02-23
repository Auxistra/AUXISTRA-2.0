import 'package:flutter/material.dart';

class PlayerScreen extends StatefulWidget {
  final String songTitle;
  final String artistName;

  const PlayerScreen({super.key, required this.songTitle, required this.artistName});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  bool _isRemixMode = false;
  double _playbackPosition = 0.3;

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
            icon: Icon(_isRemixMode ? Icons.close : Icons.tune, color: const Color(0xFF1826F8)),
            onPressed: () => setState(() => _isRemixMode = !_isRemixMode),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: _isRemixMode ? _buildRemixEditor() : _buildStandardPlayer(),
            ),
          ),
          _buildPlaybackControls(),
        ],
      ),
    );
  }

  Widget _buildStandardPlayer() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 300,
          height: 300,
          decoration: BoxDecoration(
            color: const Color(0xFF2C2C2C),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF1826F8).withOpacity(0.3),
                blurRadius: 20,
                spreadRadius: 5,
              )
            ],
          ),
          child: const Icon(Icons.music_note, size: 100, color: Colors.white),
        ),
        const SizedBox(height: 48),
        Text(widget.songTitle, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        Text(widget.artistName, style: const TextStyle(fontSize: 18, color: Colors.grey)),
      ],
    );
  }

  Widget _buildRemixEditor() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('DAW - Remix Session', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: [
                _buildTrackItem('Vocals', true, 0.8, Colors.blue),
                _buildTrackItem('Drums', true, 0.6, Colors.orange),
                _buildTrackItem('Bass', true, 0.7, Colors.purple),
                _buildTrackItem('Synths', false, 0.4, Colors.green),
              ],
            ),
          ),
          _buildDawToolbar(),
        ],
      ),
    );
  }

  Widget _buildTrackItem(String name, bool isActive, double volume, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: isActive ? color.withOpacity(0.5) : Colors.transparent),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(width: 4, height: 40, color: color),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    const Text('WAV - 24bit', style: TextStyle(fontSize: 10, color: Colors.grey)),
                  ],
                ),
              ),
              IconButton(icon: const Icon(Icons.volume_off, size: 20), onPressed: () {}),
              IconButton(icon: const Icon(Icons.headphones, size: 20), onPressed: () {}),
            ],
          ),
          Slider(
            value: volume,
            onChanged: (v) {},
            activeColor: color,
            inactiveColor: Colors.grey[800],
          ),
        ],
      ),
    );
  }

  Widget _buildDawToolbar() {
    return Container(
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
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
      ],
    );
  }

  Widget _buildPlaybackControls() {
    return Container(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Slider(
            value: _playbackPosition,
            onChanged: (v) => setState(() => _playbackPosition = v),
            activeColor: const Color(0xFF1826F8),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('1:02', style: TextStyle(fontSize: 12, color: Colors.grey)),
              Text('3:45', style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(icon: const Icon(Icons.shuffle, color: Colors.grey), onPressed: () {}),
              IconButton(icon: const Icon(Icons.skip_previous, size: 40), onPressed: () {}),
              Container(
                decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                child: IconButton(
                  icon: const Icon(Icons.play_arrow, size: 48, color: Colors.black),
                  onPressed: () {},
                ),
              ),
              IconButton(icon: const Icon(Icons.skip_next, size: 40), onPressed: () {}),
              IconButton(icon: const Icon(Icons.repeat, color: Colors.grey), onPressed: () {}),
            ],
          ),
        ],
      ),
    );
  }
}
