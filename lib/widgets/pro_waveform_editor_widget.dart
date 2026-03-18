import 'package:flutter/material.dart';

class ProWaveformEditor extends StatefulWidget {
  final List<double> waveform;
  final Duration duration;
  final Duration position;
  final Function(Duration) onSeek;

  const ProWaveformEditor({
    super.key,
    required this.waveform,
    required this.duration,
    required this.position,
    required this.onSeek,
  });

  @override
  State<ProWaveformEditor> createState() => _ProWaveformEditorState();
}

class _ProWaveformEditorState extends State<ProWaveformEditor> {

  double zoom = 1.0;

  double? loopStart;
  double? loopEnd;

  void _seek(double dx, double width) {
    final percent = dx / width;
    final newPos = widget.duration * percent;
    widget.onSeek(newPos);
  }

  @override
  Widget build(BuildContext context) {

    final progress =
        widget.position.inMilliseconds /
        widget.duration.inMilliseconds;

    return GestureDetector(

      onScaleUpdate: (details) {
        setState(() {
          zoom = (zoom * details.scale).clamp(1.0, 6.0);
        });
      },

      onHorizontalDragUpdate: (details) {
        final box = context.findRenderObject() as RenderBox;
        _seek(details.localPosition.dx, box.size.width);
      },

      child: LayoutBuilder(
        builder: (context, constraints) {

          return CustomPaint(
            size: Size(constraints.maxWidth, 120),
            painter: ProWaveformPainter(
              waveform: widget.waveform,
              zoom: zoom,
              progress: progress,
              loopStart: loopStart,
              loopEnd: loopEnd,
            ),
          );
        },
      ),
    );
  }
}

class ProWaveformPainter extends CustomPainter {

  final List<double> waveform;
  final double zoom;
  final double progress;
  final double? loopStart;
  final double? loopEnd;

  ProWaveformPainter({
    required this.waveform,
    required this.zoom,
    required this.progress,
    this.loopStart,
    this.loopEnd,
  });

  @override
  void paint(Canvas canvas, Size size) {

    final playedPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2;

    final remainingPaint = Paint()
      ..color = Colors.grey.shade700
      ..strokeWidth = 2;

    final gridPaint = Paint()
      ..color = Colors.grey.shade800
      ..strokeWidth = 1;

    final cursorPaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2;

    final samplesVisible = (waveform.length / zoom).floor();
    final widthPerSample = size.width / samplesVisible;

    /// Beat grid
    for (int i = 0; i < size.width; i += 40) {
      canvas.drawLine(
        Offset(i.toDouble(), 0),
        Offset(i.toDouble(), size.height),
        gridPaint,
      );
    }

    /// Waveform bars
    for (int i = 0; i < samplesVisible; i++) {

      final sample = waveform[i];
      final x = i * widthPerSample;

      final barHeight = sample * size.height;
      final startY = (size.height - barHeight) / 2;
      final endY = startY + barHeight;

      final paint =
          (i / samplesVisible) < progress
              ? playedPaint
              : remainingPaint;

      canvas.drawLine(
        Offset(x, startY),
        Offset(x, endY),
        paint,
      );
    }

    /// Playback cursor
    final cursorX = size.width * progress;

    canvas.drawLine(
      Offset(cursorX, 0),
      Offset(cursorX, size.height),
      cursorPaint,
    );

    /// Loop region
    if (loopStart != null && loopEnd != null) {

      final loopPaint = Paint()
        ..color = Colors.blue.withOpacity(0.2);

      final startX = size.width * loopStart!;
      final endX = size.width * loopEnd!;

      canvas.drawRect(
        Rect.fromLTRB(startX, 0, endX, size.height),
        loopPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
