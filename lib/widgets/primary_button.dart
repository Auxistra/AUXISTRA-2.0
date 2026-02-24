import 'package:flutter/material.dart';

/// Enum that defines the different styles (variants) of the button.
/// This helps maintain a consistent design system across the app.
enum ButtonVariant {
  primary,
  secondary,
  danger,
}

/// A reusable, production-ready button component for the app.
/// Improvements added:
/// - Supports loading state
/// - Supports disabled state
/// - Multiple style variants
/// - Optional icon support
/// - Consistent UI across the entire application
class PrimaryButton extends StatelessWidget {
  /// Text displayed inside the button.
  final String text;

  /// Function executed when the button is pressed.
  /// If null, the button will automatically become disabled.
  final VoidCallback? onPressed;

  /// Optional icon shown before the button text.
  final IconData? icon;

  /// Determines the style of the button (primary, secondary, danger).
  final ButtonVariant variant;

  /// Shows a loading spinner and disables the button.
  final bool isLoading;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.variant = ButtonVariant.primary,
    this.isLoading = false,
  });

  /// Method to determine button background color
  /// based on the selected variant.
  Color _getBackgroundColor() {
    switch (variant) {
      case ButtonVariant.primary:
        return const Color(0xFF1826F8); // Main brand color
      case ButtonVariant.secondary:
        return Colors.grey.shade700; // Neutral UI action
      case ButtonVariant.danger:
        return Colors.red; // Used for destructive actions
    }
  }

  @override
  Widget build(BuildContext context) {
    // The button becomes disabled when:
    // 1. onPressed is null
    // 2. The button is in loading state
    final bool isDisabled = onPressed == null || isLoading;

    return ElevatedButton(
      // Prevent button interaction when disabled or loading
      onPressed: isDisabled ? null : onPressed,

      style: ElevatedButton.styleFrom(
        // Dynamic color based on variant
        backgroundColor: _getBackgroundColor(),

        // Consistent padding for all buttons in the app
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),

        // Rounded corners for modern UI design
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),

      /// The child widget changes depending on the state
      /// (loading / icon / normal button).
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Show loading spinner if button is in loading state
          if (isLoading) ...[
            const SizedBox(
              height: 18,
              width: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 12),
          ]

          // Show icon if provided and not loading
          else if (icon != null) ...[
            Icon(icon),
            const SizedBox(width: 8),
          ],

          // Button text
          Text(text),
        ],
      ),
    );
  }
}
