import 'package:flutter/material.dart';

class ProMultiStemMixer extends StatefulWidget {
  final List<ProStemChannel> stems;
  final Function(String stem, double volume) onVolumeChange;
  final Function(String stem, bool muted) onMuteToggle;
  final Function(String stem, bool solo) onSoloToggle;
  final Function(String stem, double pan) onPanChange;

  const ProMultiStemMixer({
    super.key,
    required this.stems,
    required this.onVolumeChange,
    required this.onMuteToggle,
    required this.onSoloToggle,
    required this.onPanChange,
  });

  @override
  State<ProMultiStemMixer> createState() => _ProMultiStemMixerState();
}

class _ProMultiStemMixerState extends State<ProMultiStemMixer> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: widget.stems.map((stem) {
          return _ProStemChannelWidget(
            stem: stem,
            onVolumeChange: widget.onVolumeChange,
            onMuteToggle: widget.onMuteToggle,
            onSoloToggle: widget.onSoloToggle,
            onPanChange: widget.onPanChange,
          );
        }).toList(),
      ),
    );
  }
}

class _ProStemChannelWidget extends StatefulWidget {
  final ProStemChannel stem;
  final Function(String, double) onVolumeChange;
  final Function(String, bool) onMuteToggle;
  final Function(String, bool) onSoloToggle;
  final Function(String, double) onPanChange;

  const _ProStemChannelWidget({
    required this.stem,
    required this.onVolumeChange,
    required this.onMuteToggle,
    required this.onSoloToggle,
    required this.onPanChange,
  });

  @override
  State<_ProStemChannelWidget> createState() => _ProStemChannelWidgetState();
}

class _ProStemChannelWidgetState extends State<_ProStemChannelWidget> {
  late double volume;
  late double pan;
  late bool muted;
  late bool solo;

  @override
  void initState() {
    super.initState();
    volume = widget.stem.volume;
    pan = widget.stem.pan;
    muted = widget.stem.muted;
    solo = widget.stem.solo;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          /// Stem name
          Text(
            widget.stem.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          /// Volume slider
          SizedBox(
            height: 120,
            child: RotatedBox(
              quarterTurns: -1,
              child: Slider(
                value: volume,
                min: 0,
                max: 1,
                onChanged: (v) {
                  setState(() {
                    volume = v;
                  });
                  widget.onVolumeChange(widget.stem.name, v);
                },
              ),
            ),
          ),

          /// Pan slider
          SizedBox(
            height: 80,
            child: RotatedBox(
              quarterTurns: -1,
              child: Slider(
                value: pan,
                min: -1,
                max: 1,
                onChanged: (v) {
                  setState(() {
                    pan = v;
                  });
                  widget.onPanChange(widget.stem.name, v);
                },
              ),
            ),
          ),

          /// VU Meter (simple)
          SizedBox(
            height: 50,
            width: 20,
            child: CustomPaint(
              painter: VUMeterPainter(level: volume),
            ),
          ),

          const SizedBox(height: 8),

          /// Mute / Solo buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.volume_off, color: muted ? Colors.red : Colors.grey),
                onPressed: () {
                  setState(() {
                    muted = !muted;
                  });
                  widget.onMuteToggle(widget.stem.name, muted);
                },
              ),
              IconButton(
                icon: Icon(Icons.headphones, color: solo ? Colors.green : Colors.grey),
                onPressed: () {
                  setState(() {
                    solo = !solo;
                  });
                  widget.onSoloToggle(widget.stem.name, solo);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// VU Meter Painter
class VUMeterPainter extends CustomPainter {
  final double level; // 0.0 to 1.0
  VUMeterPainter({required this.level});

  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()..color = Colors.grey.shade800;
    final fg = Paint()..color = Colors.greenAccent;

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bg);
    canvas.drawRect(Rect.fromLTWH(0, size.height * (1 - level), size.width, size.height * level), fg);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

/// Stem Model
class ProStemChannel {
  final String name;
  double volume;
  double pan;
  bool muted;
  bool solo;

  ProStemChannel({
    required this.name,
    this.volume = 1.0,
    this.pan = 0.0,
    this.muted = false,
    this.solo = false,
  });
}
