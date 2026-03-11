import 'package:flutter/material.dart';
import 'pro_waveform_editor_widget.dart';
import 'pro_multi_stem_mixer_widget.dart';

class RemixEditorScreen extends StatefulWidget {
  const RemixEditorScreen({super.key});

  @override
  State<RemixEditorScreen> createState() => _RemixEditorScreenState();
}

class _RemixEditorScreenState extends State<RemixEditorScreen> {

  Duration trackDuration = const Duration(minutes: 3, seconds: 42);
  Duration position = Duration.zero;

  List<double> waveform = List.generate(
    500,
    (i) => (0.2 + (i % 10) * 0.08).clamp(0.1, 1.0),
  );

  late List<ProStemChannel> stems;

  @override
  void initState() {
    super.initState();

    stems = [
      ProStemChannel(name: "Vocals"),
      ProStemChannel(name: "Drums"),
      ProStemChannel(name: "Bass"),
      ProStemChannel(name: "Synth"),
      ProStemChannel(name: "FX"),
    ];
  }

  void _seek(Duration newPosition) {
    setState(() {
      position = newPosition;
    });
  }

  void _changeVolume(String stem, double volume) {
    setState(() {
      stems.firstWhere((s) => s.name == stem).volume = volume;
    });
  }

  void _toggleMute(String stem, bool muted) {
    setState(() {
      stems.firstWhere((s) => s.name == stem).muted = muted;
    });
  }

  void _toggleSolo(String stem, bool solo) {
    setState(() {
      stems.firstWhere((s) => s.name == stem).solo = solo;
    });
  }

  void _changePan(String stem, double pan) {
    setState(() {
      stems.firstWhere((s) => s.name == stem).pan = pan;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        title: const Text("Remix Editor"),
        backgroundColor: Colors.black,
        elevation: 0,
      ),

      body: SafeArea(
        child: Column(
          children: [

            /// Waveform section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ProWaveformEditor(
                waveform: waveform,
                duration: trackDuration,
                position: position,
                onSeek: _seek,
              ),
            ),

            const SizedBox(height: 20),

            /// Playback indicator
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _formatDuration(position),
                    style: const TextStyle(color: Colors.white70),
                  ),
                  Text(
                    _formatDuration(trackDuration),
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            /// Mixer section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: ProMultiStemMixer(
                  stems: stems,
                  onVolumeChange: _changeVolume,
                  onMuteToggle: _toggleMute,
                  onSoloToggle: _toggleSolo,
                  onPanChange: _changePan,
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.toString().padLeft(2, '0');
    final seconds = (d.inSeconds % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }
}
