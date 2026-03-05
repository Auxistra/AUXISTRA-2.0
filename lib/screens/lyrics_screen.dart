import 'package:flutter/material.dart';

class LyricsScreen extends StatelessWidget {
  const LyricsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [

            /// Top bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [

                  IconButton(
                    icon: const Icon(Icons.keyboard_arrow_down),
                    onPressed: () => Navigator.pop(context),
                  ),

                  const Spacer(),

                  const Text(
                    'Lyrics',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const Spacer(),

                  const SizedBox(width: 40),
                ],
              ),
            ),

            const SizedBox(height: 12),

            /// Lyrics
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                children: const [

                  _LyricLine(
                    text: 'Falling through the quiet night',
                  ),

                  _LyricLine(
                    text: 'Shadows dance beneath the light',
                    isActive: true,
                  ),

                  _LyricLine(
                    text: 'Every echo pulls me closer',
                  ),

                  _LyricLine(
                    text: 'To the sound of you',
                  ),

                  SizedBox(height: 24),

                  _LyricLine(
                    text: 'City lights and open roads',
                  ),

                  _LyricLine(
                    text: 'Hearts collide, the moment slows',
                  ),

                  _LyricLine(
                    text: 'In the silence, I still hear',
                  ),

                  _LyricLine(
                    text: 'The truth in you',
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LyricLine extends StatelessWidget {
  final String text;
  final bool isActive;

  const _LyricLine({
    required this.text,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 250),
      opacity: isActive ? 1 : 0.45,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          text,
          style: TextStyle(
            fontSize: isActive ? 22 : 18,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
            height: 1.4,
          ),
        ),
      ),
    );
  }
}
