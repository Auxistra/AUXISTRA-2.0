import 'package:flutter/material.dart';

class GesturePlaybackSurface extends StatelessWidget {
  final Widget child;

  final VoidCallback onPlayPause;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final VoidCallback onLongPress;
  final ValueChanged<double> onVerticalDrag;

  const GesturePlaybackSurface({
    super.key,
    required this.child,
    required this.onPlayPause,
    required this.onNext,
    required this.onPrevious,
    required this.onLongPress,
    required this.onVerticalDrag,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,

      onTap: onPlayPause,
      onLongPress: onLongPress,

      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity == null) return;

        if (details.primaryVelocity! < 0) {
          onNext();
        } else if (details.primaryVelocity! > 0) {
          onPrevious();
        }
      },

      onVerticalDragUpdate: (details) {
        onVerticalDrag(details.primaryDelta ?? 0);
      },

      child: child,
    );
  }
}
