import 'package:flutter/material.dart';

class PlaybackSettingsScreen extends StatelessWidget {
  final bool gapless;
  final bool replayGain;
  final bool explicitFilter;
  final double crossfadeSeconds;

  final ValueChanged<bool> onGaplessChanged;
  final ValueChanged<bool> onReplayGainChanged;
  final ValueChanged<bool> onExplicitChanged;
  final ValueChanged<double> onCrossfadeChanged;

  const PlaybackSettingsScreen({
    super.key,
    required this.gapless,
    required this.replayGain,
    required this.explicitFilter,
    required this.crossfadeSeconds,
    required this.onGaplessChanged,
    required this.onReplayGainChanged,
    required this.onExplicitChanged,
    required this.onCrossfadeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text("Playback"),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 32,
        ),
        children: [

          const _SectionLabel("Transitions"),
          const SizedBox(height: 16),

          Text(
            "Crossfade (${crossfadeSeconds.toInt()}s)",
            style: const TextStyle(fontSize: 14),
          ),
          Slider(
            value: crossfadeSeconds,
            min: 0,
            max: 12,
            divisions: 12,
            onChanged: onCrossfadeChanged,
          ),

          const SizedBox(height: 32),

          const _SectionLabel("Playback"),

          SwitchListTile(
            value: gapless,
            onChanged: onGaplessChanged,
            title: const Text("Gapless Playback"),
          ),
          SwitchListTile(
            value: replayGain,
            onChanged: onReplayGainChanged,
            title: const Text("Volume Normalization"),
          ),
          SwitchListTile(
            value: explicitFilter,
            onChanged: onExplicitChanged,
            title: const Text("Explicit Content Filter"),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String title;

  const _SectionLabel(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      style: TextStyle(
        fontSize: 12,
        letterSpacing: 1.1,
        color: Colors.grey[500],
      ),
    );
  }
}
