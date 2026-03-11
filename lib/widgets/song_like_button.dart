import 'package:flutter/material.dart';

class SongLikeButton extends StatefulWidget {
  const SongLikeButton({super.key});

  @override
  State<SongLikeButton> createState() => _SongLikeButtonState();
}

class _SongLikeButtonState extends State<SongLikeButton> {
  bool liked = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        liked ? Icons.favorite : Icons.favorite_border,
        color: liked ? Colors.red : Colors.white,
      ),
      onPressed: () {
        setState(() {
          liked = !liked;
        });
      },
    );
  }
}
