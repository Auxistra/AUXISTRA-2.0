import 'package:flutter/material.dart';

class RecentlyPlayedCarousel extends StatelessWidget {
  final List<RecentItem> items;
  final ValueChanged<RecentItem> onTap;

  const RecentlyPlayedCarousel({
    super.key,
    required this.items,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 190,

      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),

        itemCount: items.length,

        separatorBuilder: (_, __) => const SizedBox(width: 14),

        itemBuilder: (context, index) {
          final item = items[index];

          return GestureDetector(
            onTap: () => onTap(item),

            child: SizedBox(
              width: 140,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// Artwork
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),

                  Text(
                    item.subtitle,
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
        },
      ),
    );
  }
}

class RecentItem {
  final String title;
  final String subtitle;
  final String imageUrl;

  const RecentItem({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });
}
