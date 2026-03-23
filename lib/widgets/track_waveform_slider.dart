import 'package:flutter/material.dart';

class TrackWaveformSlider extends StatefulWidget {
  final double progress;
  final ValueChanged<double>? onChanged;

  const TrackWaveformSlider({
    Key? key,
    required this.progress,
    this.onChanged,
  }) : super(key: key);

  @override
  State<TrackWaveformSlider> createState() => _TrackWaveformSliderState();
}

class _TrackWaveformSliderState extends State<TrackWaveformSlider> {
  late double progress;

  @override
  void initState() {
    super.initState();
    progress = widget.progress;
  }

  void updateProgress(Offset localPosition, double width) {
    double newProgress = (localPosition.dx / width).clamp(0.0, 1.0);

    setState(() {
      progress = newProgress;
    });

    widget.onChanged?.call(progress);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;

        return GestureDetector(
          onHorizontalDragUpdate: (details) {
            updateProgress(details.localPosition, width);
          },
          onTapDown: (details) {
            updateProgress(details.localPosition, width);
          },
          child: CustomPaint(
            size: Size(width, 60),
            painter: _WaveformPainter(progress),
          ),
        );
      },
    );
  }
}

class _WaveformPainter extends CustomPainter {
  final double progress;

  _WaveformPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final activePaint = Paint()
      ..color = Colors.blueAccent
      ..strokeWidth = 3;

    final inactivePaint = Paint()
      ..color = Colors.grey.withOpacity(0.3)
      ..strokeWidth = 3;

    int bars = 60;
    double barWidth = size.width / bars;

    for (int i = 0; i < bars; i++) {
      double barHeight = (i % 5 + 1) * 6 + 10;
      double x = i * barWidth;
      double y = (size.height - barHeight) / 2;

      bool active = i / bars <= progress;

      canvas.drawLine(
        Offset(x, y),
        Offset(x, y + barHeight),
        active ? activePaint : inactivePaint,
      );
    }

    double knobX = size.width * progress;

    canvas.drawCircle(
      Offset(knobX, size.height / 2),
      6,
      Paint()..color = Colors.white,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
