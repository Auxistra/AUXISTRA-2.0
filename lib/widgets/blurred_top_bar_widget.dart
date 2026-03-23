import 'dart:ui';

class BlurredTopBar extends StatelessWidget {

  final String title;

  const BlurredTopBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 20,
          sigmaY: 20,
        ),
        child: Container(
          height: 56,
          alignment: Alignment.center,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
