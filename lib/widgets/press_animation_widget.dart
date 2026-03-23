class PressAnimation extends StatefulWidget {

  final Widget child;
  final VoidCallback onTap;

  const PressAnimation({
    super.key,
    required this.child,
    required this.onTap,
  });

  @override
  State<PressAnimation> createState() => _PressAnimationState();
}

class _PressAnimationState extends State<PressAnimation> {

  double scale = 1;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() => scale = 0.96);
      },
      onTapUp: (_) {
        setState(() => scale = 1);
        widget.onTap();
      },
      onTapCancel: () {
        setState(() => scale = 1);
      },
      child: AnimatedScale(
        duration: const Duration(milliseconds: 120),
        scale: scale,
        child: widget.child,
      ),
    );
  }
}
