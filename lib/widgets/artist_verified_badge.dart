import 'package:flutter/material.dart';

class ArtistVerifiedBadge extends StatelessWidget {
  const ArtistVerifiedBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.verified,
      color: Colors.blue,
      size: 18,
    );
  }
}
