import 'package:flutter/material.dart';

class SongRatingStars extends StatelessWidget {
  final int rating;
  final Function(int) onChanged;

  const SongRatingStars({
    super.key,
    required this.rating,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        final starIndex = index + 1;

        return GestureDetector(
          onTap: () => onChanged(starIndex),
          child: Icon(
            starIndex <= rating
                ? Icons.star_rounded
                : Icons.star_border_rounded,
            color: starIndex <= rating
                ? Colors.amber
                : Colors.white38,
            size: 22,
          ),
        );
      }),
    );
  }
}
