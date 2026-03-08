import 'package:flutter/material.dart';

class EqualizerPresetTile extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const EqualizerPresetTile({
    super.key,
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: selected
          ? const Icon(Icons.check_circle, color: Colors.green)
          : null,
      onTap: onTap,
    );
  }
}
