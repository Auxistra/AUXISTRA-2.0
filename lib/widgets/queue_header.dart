import 'package:flutter/material.dart';

/// QueueHeader is used at the top of the "Up Next" or
/// music playback queue screen.
///
/// It displays:
/// - Title of the queue
/// - Clear queue button
/// - Optional queue count
class QueueHeader extends StatelessWidget {
  final int songCount;
  final VoidCallback? onClear;

  const QueueHeader({
    super.key,
    required this.songCount,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// Queue title
        Text(
          "Up Next ($songCount)",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        /// Clear queue button
        TextButton.icon(
          onPressed: onClear,
          icon: const Icon(Icons.clear_all),
          label: const Text("Clear"),
        )
      ],
    );
  }
}
