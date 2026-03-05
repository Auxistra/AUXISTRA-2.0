import 'package:flutter/material.dart';

class ArtistDiscographyScreen extends StatelessWidget {
  final String artistName;

  const ArtistDiscographyScreen({
    super.key,
    required this.artistName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          artistName,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 24,
        ),
        children: const [
          _DiscographySection(
            title: "Albums",
            items: [
              ReleaseItem("Northern Lights", "2024"),
              ReleaseItem("Fragments", "2022"),
              ReleaseItem("Echo Patterns", "2020"),
            ],
          ),

          SizedBox(height: 32),

          _DiscographySection(
            title: "Singles",
            items: [
              ReleaseItem("Gravity", "2025"),
              ReleaseItem("Fade Away", "2024"),
              ReleaseItem("Blue Static", "2023"),
              ReleaseItem("Night Pulse", "2022"),
            ],
          ),

          SizedBox(height: 32),

          _DiscographySection(
            title: "Features",
            items: [
              ReleaseItem("Afterglow", "2024"),
              ReleaseItem("Skyline Drive", "2023"),
            ],
          ),
        ],
      ),
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
            mainAxisSpacing: 18,
            crossAxisSpacing: 16,
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
