import 'package:flutter/material.dart';

class OfflineDownloadIndicator extends StatelessWidget {
  final double progress; // 0.0 → 1.0
  final bool isDownloaded;
  final VoidCallback? onTap;

  const OfflineDownloadIndicator({
    super.key,
    required this.progress,
    required this.isDownloaded,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: SizedBox(
        width: 26,
        height: 26,

        child: Stack(
          alignment: Alignment.center,
          children: [

            /// Progress Ring
            if (!isDownloaded)
              CircularProgressIndicator(
                value: progress.clamp(0.0, 1.0),
                strokeWidth: 2.4,
              ),

            /// Downloaded Icon
            if (isDownloaded)
              const Icon(
                Icons.check_circle,
                size: 22,
              ),

            /// Download Icon
            if (!isDownloaded && progress == 0)
              const Icon(
                Icons.download,
                size: 18,
              ),
          ],
        ),
      ),
    );
  }
}
