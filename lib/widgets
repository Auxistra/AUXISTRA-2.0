import 'package:flutter/material.dart';

/// A reusable custom switch tile widget.
/// This wraps Flutter's SwitchListTile and allows you to easily
/// provide a title, subtitle, switch value, and a callback.
class CustomSwitchTile extends StatelessWidget {
  /// Main text displayed on the tile.
  final String title;

  /// Secondary text displayed under the title.
  final String subtitle;

  /// Current state of the switch (true = ON, false = OFF).
  final bool value;

  /// Callback triggered when the switch is toggled.
  /// Returns the updated boolean value.
  final ValueChanged<bool> onChanged;

  /// Constructor for the CustomSwitchTile widget.
  /// Requires all fields to ensure proper usage.
  const CustomSwitchTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    // Builds the UI for the switch tile.
    return SwitchListTile(
      // Displays the main title text.
      title: Text(title),

      // Displays additional description text below the title.
      subtitle: Text(subtitle),

      // Determines whether the switch is ON or OFF.
      value: value,

      // Sets the color of the switch when it is active (ON).
      activeColor: const Color(0xFF1826F8),

      // Handles the switch toggle event.
      // Calls the function passed from the parent widget.
      onChanged: onChanged,
    );
  }
}
