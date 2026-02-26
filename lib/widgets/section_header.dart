import 'package:flutter/material.dart';

/// SectionHeader
/// A reusable header used across the app for listing sections.
/// Example: Trending Tracks, Your Mixes, Recommended for You
class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAll;

  const SectionHeader({
    super.key,
    required this.title,
    this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// Section Title
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        /// Optional "See All" button
        if (onSeeAll != null)
          TextButton(
            onPressed: onSeeAll,
            child: const Text("See All"),
          ),
      ],
    );
  }
}
