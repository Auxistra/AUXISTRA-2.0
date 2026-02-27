import 'dart:async';
import 'package:flutter/material.dart';

class CollaborationTile extends StatefulWidget {

  final String name;
  final String project;
  final int delay;

  const CollaborationTile({
    super.key,
    required this.name,
    required this.project,
    required this.delay,
  });

  @override
  State<CollaborationTile> createState() =>
      _CollaborationTileState();
}

class _CollaborationTileState
    extends State<CollaborationTile>
    with SingleTickerProviderStateMixin {

  late AnimationController controller;
  late Animation<double> fade;
  late Animation<Offset> slide;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration:
          const Duration(milliseconds: 600),
    );

    fade = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOut,
      ),
    );

    slide = Tween(
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOutCubic,
      ),
    );

    // stagger animation delay
    Timer(
      Duration(milliseconds: widget.delay),
      () => controller.forward(),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return FadeTransition(
      opacity: fade,

      child: SlideTransition(
        position: slide,

        child: Container(
          padding:
              const EdgeInsets.all(16),

          decoration: BoxDecoration(
            color:
                const Color(0xFF1C1C1E),
            borderRadius:
                BorderRadius.circular(14),
          ),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              Text(
                widget.name,
                style:
                    const TextStyle(
                  fontSize: 17,
                  fontWeight:
                      FontWeight.w600,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                widget.project,
                style: TextStyle(
                  color:
                      Colors.grey[400],
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 14),

              Row(
                children: [

                  Expanded(
                    child:
                        OutlinedButton(
                      onPressed: () {},
                      child:
                          const Text(
                              'Decline'),
                    ),
                  ),

                  const SizedBox(
                      width: 10),

                  Expanded(
                    child:
                        ElevatedButton(
                      onPressed: () {},
                      child:
                          const Text(
                              'Accept'),
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
}
