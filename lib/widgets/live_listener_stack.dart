import 'package:flutter/material.dart';

class LiveListenerStack extends StatelessWidget {
  final List<String> imageUrls;
  final int extraCount;

  const LiveListenerStack({
    super.key,
    required this.imageUrls,
    this.extraCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Stack(
        children: [
          for (int i = 0; i < imageUrls.length; i++)
            Positioned(
              left: i * 25,
              child: CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage(imageUrls[i]),
              ),
            ),
          if (extraCount > 0)
            Positioned(
              left: imageUrls.length * 25,
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.grey[800],
                child: Text(
                  "+$extraCount",
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
