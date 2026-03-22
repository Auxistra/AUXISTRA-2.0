import 'package:flutter/material.dart';

class MultiStemMixer extends StatefulWidget {
  final List<StemChannel> stems;
  final Function(String stem, double volume) onVolumeChange;
  final Function(String stem, bool muted) onMuteToggle;
  final Function(String stem, bool solo) onSoloToggle;

  const MultiStemMixer({
    super.key,
    required this.stems,
    required this.onVolumeChange,
    required this.onMuteToggle,
    required this.onSoloToggle,
  });

  @override
  State<MultiStemMixer> createState() => _MultiStemMixerState();
}

class _MultiStemMixerState extends State<MultiStemMixer> {

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: widget.stems.map((stem) {
        return _StemChannelWidget(
          stem: stem,
          onVolumeChange: widget.onVolumeChange,
          onMuteToggle: widget.onMuteToggle,
          onSoloToggle: widget.onSoloToggle,
        );
      }).toList(),
    );
  }
}

class _StemChannelWidget extends StatefulWidget {
  final StemChannel stem;
  final Function(String, double) onVolumeChange;
  final Function(String, bool) onMuteToggle;
  final Function(String, bool) onSoloToggle;

  const _StemChannelWidget({
    required this.stem,
    required this.onVolumeChange,
    required this.onMuteToggle,
    required this.onSoloToggle,
  });

  @override
  State<_StemChannelWidget> createState() => _StemChannelWidgetState();
}

class _StemChannelWidgetState extends State<_StemChannelWidget> {

  late double volume;
  late bool muted;
  late bool solo;

  @override
  void initState() {
    super.initState();
    volume = widget.stem.volume;
    muted = widget.stem.muted;
    solo = widget.stem.solo;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        /// Stem name
        Text(
          widget.stem.name,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),

        const SizedBox(height: 10),

        /// Vertical slider
        RotatedBox(
          quarterTurns: -1,
          child: Slider(
            value: volume,
            min: 0,
            max: 1,
            onChanged: (value) {
              setState(() {
                volume = value;
              });
              widget.onVolumeChange(widget.stem.name, value);
            },
          ),
        ),

        const SizedBox(height: 8),

        /// Mute button
        IconButton(
          icon: Icon(
            Icons.volume_off,
            color: muted ? Colors.red : Colors.grey,
          ),
          onPressed: () {
            setState(() {
              muted = !muted;
            });
            widget.onMuteToggle(widget.stem.name, muted);
          },
        ),

        /// Solo button
        IconButton(
          icon: Icon(
            Icons.headphones,
            color: solo ? Colors.green : Colors.grey,
          ),
          onPressed: () {
            setState(() {
              solo = !solo;
            });
            widget.onSoloToggle(widget.stem.name, solo);
          },
        ),
      ],
    );
  }
}

class StemChannel {
  final String name;
  double volume;
  bool muted;
  bool solo;

  StemChannel({
    required this.name,
    this.volume = 1.0,
    this.muted = false,
    this.solo = false,
  });
}
