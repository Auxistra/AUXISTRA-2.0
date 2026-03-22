import 'package:flutter/material.dart';

class ArtistFollowButton extends StatefulWidget {
  const ArtistFollowButton({super.key});

  @override
  State<ArtistFollowButton> createState() => _ArtistFollowButtonState();
}

class _ArtistFollowButtonState extends State<ArtistFollowButton> {
  bool following = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          following = !following;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: following ? Colors.grey : const Color(0xFF1826F8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(
        following ? "Following" : "Follow",
      ),
    );
  }
}
