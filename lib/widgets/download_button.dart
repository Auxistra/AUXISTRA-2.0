import 'package:flutter/material.dart';

/// DownloadButton represents a track download action.
/// It visually communicates three states:
/// - Not downloaded
/// - Downloading (progress indicator)
/// - Downloaded
///
/// This is useful in:
/// - Song lists
/// - Album screens
/// - Offline download management
class DownloadButton extends StatelessWidget {
  /// Indicates whether the track has already been downloaded
  final bool isDownloaded;

  /// Indicates whether the download is currently in progress
  final bool isDownloading;

  /// Callback when the button is pressed
  final VoidCallback? onPressed;

  const DownloadButton({
    super.key,
    this.isDownloaded = false,
    this.isDownloading = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    Widget icon;

    // Determine which icon should appear based on download state
    if (isDownloading) {
      icon = const SizedBox(
        width: 18,
        height: 18,
        child: CircularProgressIndicator(strokeWidth: 2),
      );
    } else if (isDownloaded) {
      icon = const Icon(Icons.check_circle, color: Colors.green);
    } else {
      icon = const Icon(Icons.download);
    }

    return IconButton(
      icon: icon,
      onPressed: onPressed,
      tooltip: "Download track",
    );
  }
}
