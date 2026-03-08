import 'package:flutter/material.dart';

class WaveformScrubber extends StatefulWidget {
  final List<double> waveformData;
  final Duration duration;
  final Duration position;
  final Function(Duration) onSeek;

  const WaveformScrubber({
    super.key,
    required this.waveformData,
    required this.duration,
    required this.position,
    required this.onSeek,
  });

  @override
  State<WaveformScrubber> createState() => _WaveformScrubberState();
}

class _WaveformScrubberState extends State<WaveformScrubber> {

  void _seek(double dx, double width) {
    final percent = dx / width;
    final newPosition = widget.duration * percent;
    widget.onSeek(newPosition);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {

        final progress =
            widget.position.inMilliseconds /
            widget.duration.inMilliseconds;

        return GestureDetector(
          onHorizontalDragUpdate: (details) {
            _seek(details.localPosition.dx, constraints.maxWidth);
          },
          onTapDown: (details) {
            _seek(details.localPosition.dx, constraints.maxWidth);
          },
          child: CustomPaint(
            size: Size(constraints.maxWidth, 80),
            painter: WaveformPainter(
              waveformData: widget.waveformData,
              progress: progress,
            ),
          ),
        );
      },
    );
  }
}

class WaveformPainter extends CustomPainter {
  final List<double> waveformData;
  final double progress;

  WaveformPainter({
    required this.waveformData,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {

    final playedPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2;

    final unplayedPaint = Paint()
      ..color = Colors.grey.shade700
      ..strokeWidth = 2;

    final widthPerSample = size.width / waveformData.length;

    for (int i = 0; i < waveformData.length; i++) {

      final x = i * widthPerSample;

      final barHeight = waveformData[i] * size.height;

      final startY = (size.height - barHeight) / 2;
      final endY = startY + barHeight;

      final paint =
          (i / waveformData.length) < progress
              ? playedPaint
              : unplayedPaint;

      canvas.drawLine(
        Offset(x, startY),
        Offset(x, endY),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
