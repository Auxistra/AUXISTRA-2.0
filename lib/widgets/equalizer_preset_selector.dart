import 'package:flutter/material.dart';

class EqualizerPresetSelector extends StatelessWidget {
  final List<String> presets;
  final String selectedPreset;
  final ValueChanged<String> onChanged;

  const EqualizerPresetSelector({
    super.key,
    required this.presets,
    required this.selectedPreset,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,

      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),

        itemCount: presets.length,

        separatorBuilder: (_, __) => const SizedBox(width: 10),

        itemBuilder: (context, index) {
          final preset = presets[index];
          final isSelected = preset == selectedPreset;

          return GestureDetector(
            onTap: () => onChanged(preset),

            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),

              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white
                    : const Color(0xFF2C2C2E),
                borderRadius: BorderRadius.circular(22),
              ),

              child: Center(
                child: Text(
                  preset,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: isSelected
                        ? Colors.black
                        : Colors.grey[300],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
