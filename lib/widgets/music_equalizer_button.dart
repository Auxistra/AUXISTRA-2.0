import 'package:flutter/material.dart';

class MusicEqualizerButton extends StatefulWidget {
  final VoidCallback onTap;
  final bool isActive;

  const MusicEqualizerButton({
    super.key,
    required this.onTap,
    required this.isActive,
  });

  @override
  State<MusicEqualizerButton> createState() => _MusicEqualizerButtonState();
}

class _MusicEqualizerButtonState extends State<MusicEqualizerButton>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);
  }

  @override
  void didUpdateWidget(covariant MusicEqualizerButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive) {
      _controller.repeat(reverse: true);
    } else {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _bar(double height) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Container(
          width: 4,
          height: widget.isActive
              ? height * _controller.value + 5
              : 5,
          decoration: BoxDecoration(
            color: widget.isActive ? Colors.pinkAccent : Colors.white38,
            borderRadius: BorderRadius.circular(2),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _bar(20),
          const SizedBox(width: 3),
          _bar(28),
          const SizedBox(width: 3),
          _bar(16),
        ],
      ),
    );
  }
}
