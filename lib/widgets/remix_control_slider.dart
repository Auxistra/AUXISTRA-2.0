import 'package:flutter/material.dart';

/// RemixControlSlider
/// Used in the remixing interface (DAW-like controls)
/// Allows adjusting sound parameters such as volume, bass, tempo etc.
class RemixControlSlider extends StatelessWidget {
  final String label;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;

  const RemixControlSlider({
    super.key,
    required this.label,
    required this.value,
    this.min = 0,
    this.max = 1,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Label showing what this slider controls
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),

        Slider(
          value: value,
          min: min,
          max: max,
          onChanged: onChanged, // Updates remix parameter
        ),
      ],
    );
  }
}
