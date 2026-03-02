import 'package:flutter/material.dart';

class CollaborationCard extends StatefulWidget {

  final String name;
  final String project;
  final String image;

  const CollaborationCard({
    super.key,
    required this.name,
    required this.project,
    required this.image,
  });

  @override
  State<CollaborationCard> createState()
      => _CollaborationCardState();
}

class _CollaborationCardState
    extends State<CollaborationCard>
    with SingleTickerProviderStateMixin {

  late AnimationController controller;

  /// Fade Animation
  late Animation<double> fade;

  /// Slide Animation (Left → Right)
  late Animation<Offset> slide;

  /// Bounce Animation
  late Animation<double> scale;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration:
          const Duration(milliseconds: 800),
    );

    /// Fade
    fade = CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
    );

    /// Slide Animation
    slide = Tween<Offset>(
      begin: const Offset(-0.3, 0), // start left
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOutCubic,
      ),
    );

    /// Bounce Scale Animation
    scale = Tween<double>(
      begin: 0.85,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.elasticOut,
      ),
    );

    controller.forward();
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

        child: ScaleTransition(

          scale: scale,

          child: Container(
            margin:
                const EdgeInsets.only(bottom: 14),

            padding:
                const EdgeInsets.all(16),

            decoration: BoxDecoration(
              color:
                  const Color(0xFF1C1C1E),

              borderRadius:
                  BorderRadius.circular(18),
            ),

            child: Row(
              children: [

                /// Avatar
                Stack(
                  children: [

                    CircleAvatar(
                      radius: 26,
                      backgroundImage:
                          AssetImage(
                              widget.image),
                    ),

                    Positioned(
                      bottom: 2,
                      right: 2,

                      child: Container(
                        height: 10,
                        width: 10,

                        decoration:
                            const BoxDecoration(
                          color:
                              Colors.green,
                          shape:
                              BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(width: 14),

                /// Name + Project
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,

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

                      const SizedBox(
                          height: 4),

                      Text(
                        widget.project,
                        style:
                            TextStyle(
                          color: Colors
                              .grey[400],
                        ),
                      ),
                    ],
                  ),
                ),

                /// Accept Button
                IconButton(
                  onPressed: () {},

                  icon: Container(
                    padding:
                        const EdgeInsets
                            .all(8),

                    decoration:
                        BoxDecoration(
                      color:
                          Colors.green,

                      borderRadius:
                          BorderRadius
                              .circular(
                                  10),
                    ),

                    child:
                        const Icon(
                      Icons.check,
                      color:
                          Colors.white,
                    ),
                  ),
                ),

                /// Decline Button
                IconButton(
                  onPressed: () {},

                  icon: Container(
                    padding:
                        const EdgeInsets
                            .all(8),

                    decoration:
                        BoxDecoration(
                      color:
                          Colors.red,

                      borderRadius:
                          BorderRadius
                              .circular(
                                  10),
                    ),

                    child:
                        const Icon(
                      Icons.close,
                      color:
                          Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
