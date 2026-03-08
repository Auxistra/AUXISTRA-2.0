import 'package:flutter/material.dart';

class CollaboratorInviteCard extends StatelessWidget {
  final String username;
  final String avatarUrl;
  final VoidCallback? onInvite;

  const CollaboratorInviteCard({
    Key? key,
    required this.username,
    required this.avatarUrl,
    this.onInvite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade900,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(avatarUrl),
        ),
        title: Text(
          username,
          style: const TextStyle(color: Colors.white),
        ),
        trailing: ElevatedButton(
          onPressed: onInvite,
          child: const Text("Invite"),
        ),
      ),
    );
  }
}
