import 'package:flutter/material.dart';

class MiniPlayer extends StatelessWidget {
  final String title;
  final String artist;
  final String? imageUrl;
  final bool isPlaying;
  final VoidCallback? onTap;
  final VoidCallback? onPlayPause;
  final VoidCallback? onNext;

  const MiniPlayer({
    super.key,
    required this.title,
    required this.artist,
    this.imageUrl,
    required this.isPlaying,
    this.onTap,
    this.onPlayPause,
    this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 64,
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF1C1C1E),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [

            /// Artwork
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Container(
                width: 44,
                height: 44,
                color: const Color(0xFF2C2C2C),
                child: imageUrl != null
                    ? Image.network(
                        imageUrl!,
                        fit: BoxFit.cover,
                      )
                    : const Icon(Icons.music_note),
              ),
            ),

            const SizedBox(width: 12),

            /// Title + Artist
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 2),

                  Text(
                    artist,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),

            /// Play / Pause
            IconButton(
              icon: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
                size: 28,
              ),
              onPressed: onPlayPause,
            ),

            /// Next
            IconButton(
              icon: const Icon(Icons.skip_next),
              onPressed: onNext,
            ),
          ],
        ),
      ),
    );
  }
}
