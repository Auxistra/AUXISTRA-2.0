import 'package:flutter/material.dart';

class CollaborationScreen extends StatefulWidget {
  const CollaborationScreen({super.key});

  @override
  State<CollaborationScreen> createState() =>
      _CollaborationScreenState();
}

class _CollaborationScreenState
    extends State<CollaborationScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _fadeAnimation =
        Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _slideAnimation =
        Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget requestTile({
    required String name,
    required String project,
  }) {
    return FadeTransition(
      opacity: _fadeAnimation,

      child: SlideTransition(
        position: _slideAnimation,

        child: Container(
          padding: const EdgeInsets.all(16),

          decoration: BoxDecoration(
            color: const Color(0xFF1C1C1E),
            borderRadius: BorderRadius.circular(14),
          ),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

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
                      child:
                          const Text('Decline'),
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child:
                          const Text('Accept'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 20),

          child: ListView(
            children: [

              const SizedBox(height: 10),

              const Text(
                'Collaborations',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight:
                      FontWeight.w700,
                  letterSpacing: -0.5,
                ),
              ),

              const SizedBox(height: 24),

              requestTile(
                name: 'Alex Rivera',
                project:
                    'Synthwave Remix',
              ),

              const SizedBox(height: 14),

              requestTile(
                name: 'Luna Beats',
                project:
                    'Vocal Collaboration',
              ),

              const SizedBox(height: 14),

              requestTile(
                name: 'Nova Sound',
                project:
                    'Drum Production',
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
