import 'package:flutter/material.dart';

class CollaboratorAvatarStack extends StatelessWidget {
  final List<String> avatars;
  final double size;

  const CollaboratorAvatarStack({
    Key? key,
    required this.avatars,
    this.size = 40,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      child: Stack(
        children: List.generate(avatars.length, (index) {
          return Positioned(
            left: index * (size * 0.6),
            child: CircleAvatar(
              radius: size / 2,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: size / 2.2,
                backgroundImage: NetworkImage(avatars[index]),
              ),
            ),
          );
        }),
      ),
    );
  }
}
