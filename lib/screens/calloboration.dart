import 'package:flutter/material.dart';

class CollaborationScreen extends StatelessWidget {
  const CollaborationScreen({super.key});

  Widget requestTile({
    required String name,
    required String project,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(14),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Text(
            name,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            project,
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 14),

          Row(
            children: [

              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  child: const Text('Decline'),
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Accept'),
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),

          child: ListView(
            children: [

              const SizedBox(height: 10),

              const Text(
                'Collaborations',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                ),
              ),

              const SizedBox(height: 24),

              requestTile(
                name: 'Alex Rivera',
                project: 'Synthwave Remix',
              ),

              const SizedBox(height: 14),

              requestTile(
                name: 'Luna Beats',
                project: 'Vocal Collaboration',
              ),

              const SizedBox(height: 14),

              requestTile(
                name: 'Nova Sound',
                project: 'Drum Production',
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
