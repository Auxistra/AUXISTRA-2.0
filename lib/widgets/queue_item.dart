import 'package:flutter/material.dart';

class QueueItem extends StatelessWidget {
  final String title;
  final String artist;
  final String? imageUrl;
  final bool isCurrent;
  final VoidCallback? onTap;

  const QueueItem({
    super.key,
    required this.title,
    required this.artist,
    this.imageUrl,
    this.isCurrent = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        color: isCurrent
            ? theme.colorScheme.primary.withOpacity(0.08)
            : Colors.transparent,
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

            /// Song info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: isCurrent
                          ? FontWeight.bold
                          : FontWeight.w500,
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

            /// Playing indicator
            if (isCurrent)
              const Icon(
                Icons.equalizer,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}
