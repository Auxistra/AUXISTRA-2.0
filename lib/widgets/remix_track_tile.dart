import 'package:flutter/material.dart';

class RemixTrackTile extends StatelessWidget {
  final String trackName;
  final double volume;
  final ValueChanged<double> onVolumeChanged;

  const RemixTrackTile({
    super.key,
    required this.trackName,
    required this.volume,
    required this.onVolumeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  trackName,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold),
                ),
              ),
              const Icon(Icons.graphic_eq,
                  color: Color(0xFF1826F8)),
            ],
          ),
          Slider(
            value: volume,
            onChanged: onVolumeChanged,
            activeColor: const Color(0xFF1826F8),
          ),
        ],
      ),
    );
  }
}
