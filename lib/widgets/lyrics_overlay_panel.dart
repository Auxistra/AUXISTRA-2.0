import 'package:flutter/material.dart';

class LyricsOverlayPanel extends StatelessWidget {
  final String lyrics;
  final VoidCallback onClose;

  const LyricsOverlayPanel({
    super.key,
    required this.lyrics,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.95),

      child: SafeArea(
        child: Column(
          children: [

            /// Header
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              child: Row(
                children: [

                  const Text(
                    'Lyrics',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const Spacer(),

                  IconButton(
                    onPressed: onClose,
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),

            const Divider(height: 1),

            /// Lyrics Body
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),

                child: Text(
                  lyrics,
                  style: const TextStyle(
                    fontSize: 18,
                    height: 1.6,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
