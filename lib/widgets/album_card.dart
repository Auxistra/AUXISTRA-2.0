import 'package:flutter/material.dart';

class AlbumCard extends StatelessWidget {
  final String title;
  final String artist;
  final String imageUrl;
  final VoidCallback? onTap;

  const AlbumCard({
    super.key,
    required this.title,
    required this.artist,
    required this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 140,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// Album Artwork
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imageUrl,
                width: 140,
                height: 140,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 8),

            /// Album Title
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),

            /// Artist Name
            Text(
              artist,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
