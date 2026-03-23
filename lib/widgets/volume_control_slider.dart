import 'package:flutter/material.dart';

class VolumeControlSlider extends StatefulWidget {
  const VolumeControlSlider({super.key});

  @override
  State<VolumeControlSlider> createState() => _VolumeControlSliderState();
}

class _VolumeControlSliderState extends State<VolumeControlSlider> {
  double volume = 0.5;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.volume_down, color: Colors.white70),
        Expanded(
          child: Slider(
            value: volume,
            onChanged: (v) {
              setState(() {
                volume = v;
              });
            },
            activeColor: const Color(0xFF1826F8),
          ),
        ),
        const Icon(Icons.volume_up, color: Colors.white70),
      ],
    );
  }
}
