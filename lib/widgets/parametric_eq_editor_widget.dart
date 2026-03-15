import 'package:flutter/material.dart';
import 'dart:math';

class ParametricEQEditor extends StatefulWidget {
  final List<EQBand> bands;
  final Function(List<EQBand>) onChanged;

  const ParametricEQEditor({
    super.key,
    required this.bands,
    required this.onChanged,
  });

  @override
  State<ParametricEQEditor> createState() => _ParametricEQEditorState();
}

class _ParametricEQEditorState extends State<ParametricEQEditor> {

  int? selectedBand;

  void _updateBand(Offset pos, Size size) {
    if (selectedBand == null) return;

    final band = widget.bands[selectedBand!];

    double freq = (pos.dx / size.width) * 20000;
    freq = freq.clamp(20, 20000);

    double gain = (0.5 - (pos.dy / size.height)) * 24;
    gain = gain.clamp(-12, 12);

    setState(() {
      band.frequency = freq;
      band.gain = gain;
    });

    widget.onChanged(widget.bands);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {

        return GestureDetector(

          onPanStart: (details) {
            final pos = details.localPosition;

            for (int i = 0; i < widget.bands.length; i++) {
              final band = widget.bands[i];

              double x = (band.frequency / 20000) * constraints.maxWidth;
              double y = constraints.maxHeight *
                  (0.5 - (band.gain / 24));

              if ((Offset(x, y) - pos).distance < 20) {
                selectedBand = i;
              }
            }
          },

          onPanUpdate: (details) {
            _updateBand(details.localPosition, constraints.biggest);
          },

          onPanEnd: (_) {
            selectedBand = null;
          },

          child: CustomPaint(
            size: Size.infinite,
            painter: _EQPainter(widget.bands),
          ),
        );
      },
    );
  }
}

class _EQPainter extends CustomPainter {

  final List<EQBand> bands;

  _EQPainter(this.bands);

  @override
  void paint(Canvas canvas, Size size) {

    final gridPaint = Paint()
      ..color = Colors.grey.shade800
      ..strokeWidth = 1;

    final curvePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final bandPaint = Paint()
      ..color = Colors.blueAccent;

    /// grid
    for (int i = 0; i <= 6; i++) {
      double y = size.height * (i / 6);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    for (int i = 0; i <= 6; i++) {
      double x = size.width * (i / 6);
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }

    /// curve
    final path = Path();

    for (int i = 0; i < size.width; i++) {

      double freq = (i / size.width) * 20000;

      double gain = 0;

      for (var band in bands) {
        double distance = (freq - band.frequency).abs();
        gain += band.gain * exp(-distance / 2000);
      }

      double y = size.height * (0.5 - gain / 24);

      if (i == 0) {
        path.moveTo(i.toDouble(), y);
      } else {
        path.lineTo(i.toDouble(), y);
      }
    }

    canvas.drawPath(path, curvePaint);

    /// band handles
    for (var band in bands) {

      double x = (band.frequency / 20000) * size.width;
      double y = size.height * (0.5 - (band.gain / 24));

      canvas.drawCircle(Offset(x, y), 8, bandPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class EQBand {

  double frequency;
  double gain;
  double q;

  EQBand({
    required this.frequency,
    required this.gain,
    this.q = 1.0,
  });
}
