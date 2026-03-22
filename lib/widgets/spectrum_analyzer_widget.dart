import 'package:flutter/material.dart';
import 'dart:math';

class SpectrumAnalyzer extends StatefulWidget {
  final List<double> spectrumData; // values between 0–1

  const SpectrumAnalyzer({
    super.key,
    required this.spectrumData,
  });

  @override
  State<SpectrumAnalyzer> createState() => _SpectrumAnalyzerState();
}

class _SpectrumAnalyzerState extends State<SpectrumAnalyzer>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;

  List<List<double>> history = [];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 50),
    )..addListener(() {
        setState(() {
          history.add(List.from(widget.spectrumData));

          if (history.length > 60) {
            history.removeAt(0);
          }
        });
      });

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _SpectrumPainter(history),
      size: const Size(double.infinity, 120),
    );
  }
}

class _SpectrumPainter extends CustomPainter {

  final List<List<double>> history;

  _SpectrumPainter(this.history);

  @override
  void paint(Canvas canvas, Size size) {

    final barWidth = size.width / (history.isNotEmpty ? history.last.length : 1);

    for (int t = 0; t < history.length; t++) {

      final frame = history[t];

      for (int i = 0; i < frame.length; i++) {

        final value = frame[i];
        final height = value * size.height;

        final x = i * barWidth;
        final y = size.height - height;

        final opacity = t / history.length;

        final paint = Paint()
          ..color = Colors.white.withOpacity(opacity);

        canvas.drawRect(
          Rect.fromLTWH(x, y, barWidth * 0.8, height),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
