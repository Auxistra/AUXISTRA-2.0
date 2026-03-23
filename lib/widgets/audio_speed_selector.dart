import 'package:flutter/material.dart';

class AudioSpeedSelector extends StatelessWidget {
  final double currentSpeed;
  final Function(double) onChanged;

  const AudioSpeedSelector({
    super.key,
    required this.currentSpeed,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final speeds = [0.5, 1.0, 1.5, 2.0];

    return Row(
      children: speeds.map((speed) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: ChoiceChip(
            label: Text("${speed}x"),
            selected: speed == currentSpeed,
            onSelected: (_) => onChanged(speed),
          ),
        );
      }).toList(),
    );
  }
}
