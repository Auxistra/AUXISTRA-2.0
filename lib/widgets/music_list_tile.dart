import 'package:flutter/material.dart';

class MusicListTile extends StatelessWidget {
  final String title;
  final String artist;
  final String? imageUrl;
  final VoidCallback? onTap;
  final VoidCallback? onMore;

  const MusicListTile({
    super.key,
    required this.title,
    required this.artist,
    this.imageUrl,
    this.onTap,
    this.onMore,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        child: Row(
          children: [

            /// Album Art
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Container(
                width: 48,
                height: 48,
                color: const Color(0xFF2C2C2C),
                child: imageUrl != null
                    ? Image.network(
                        imageUrl!,
                        fit: BoxFit.cover,
                      )
                    : const Icon(Icons.music_note),
              ),
            ),

            const SizedBox(width: 14),

            /// Title + Artist
            Expanded(
              child: Column(
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

                  const SizedBox(height: 4),

                  Text(
                    artist,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),

            /// More Button
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: onMore,
            ),
          ],
        ),
      ),
    );
  }
}
