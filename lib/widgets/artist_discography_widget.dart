import 'package:flutter/material.dart';

class ArtistDiscographyWidget extends StatelessWidget {
  final List<ReleaseItem> albums;
  final List<ReleaseItem> singles;
  final List<ReleaseItem> features;

  const ArtistDiscographyWidget({
    super.key,
    required this.albums,
    required this.singles,
    required this.features,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        if (albums.isNotEmpty)
          _DiscographySection(
            title: "Albums",
            items: albums,
          ),

        if (singles.isNotEmpty) ...[
          const SizedBox(height: 32),
          _DiscographySection(
            title: "Singles",
            items: singles,
          ),
        ],

        if (features.isNotEmpty) ...[
          const SizedBox(height: 32),
          _DiscographySection(
            title: "Features",
            items: features,
          ),
        ],
      ],
    );
  }
}

class _DiscographySection extends StatelessWidget {
  final String title;
  final List<ReleaseItem> items;

  const _DiscographySection({
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          title.toUpperCase(),
          style: TextStyle(
            fontSize: 12,
            letterSpacing: 1.1,
            color: Colors.grey[500],
          ),
        ),

        const SizedBox(height: 16),

        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 18,
            childAspectRatio: 0.9,
          ),
          itemBuilder: (context, index) {
            final item = items[index];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Container(
                  height: 140,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1C1C1E),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  item.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 2),

                Text(
                  item.year,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class ReleaseItem {
  final String title;
  final String year;

  const ReleaseItem(this.title, this.year);
}
