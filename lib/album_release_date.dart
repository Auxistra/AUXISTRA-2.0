import 'package:flutter/material.dart';

class AlbumReleaseDate extends StatelessWidget {
  final String date;

  const AlbumReleaseDate({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.calendar_today, size: 14),
        const SizedBox(width: 6),
        Text(date),
      ],
    );
  }
}
