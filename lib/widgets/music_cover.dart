import 'package:flutter/material.dart';

/// A professional music cover widget used to display album artwork.
/// Features added:
/// - Loads real album images from the internet
/// - Fallback UI if image fails
/// - Glow effect for currently playing song
/// - Optional rotation animation while music is playing
class MusicCover extends StatefulWidget {
  /// Size of the cover (width & height).
  final double size;

  /// Image URL for the album artwork.
  final String? imageUrl;

  /// Enables glow effect when the track is playing.
  final bool glow;

  /// Enables rotation animation (used for Now Playing screen).
  final bool isPlaying;

  const MusicCover({
    super.key,
    this.size = 250,
    this.imageUrl,
    this.glow = false,
    this.isPlaying = false,
  });

  @override
  State<MusicCover> createState() => _MusicCoverState();
}

class _MusicCoverState extends State<MusicCover>
    with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();

    /// Animation controller used to rotate the album cover.
    /// This mimics the effect of a spinning vinyl or playing music artwork.
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );

    /// If music is playing, start rotating.
    if (widget.isPlaying) {
      _rotationController.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant MusicCover oldWidget) {
    super.didUpdateWidget(oldWidget);

    /// If play state changes, update animation accordingly.
    if (widget.isPlaying) {
      _rotationController.repeat();
    } else {
      _rotationController.stop();
    }
  }

  @override
  void dispose() {
    /// Always dispose animations to prevent memory leaks.
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget coverContent;

    /// If an image URL is provided, load album artwork from network.
    if (widget.imageUrl != null) {
      coverContent = ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(
          widget.imageUrl!,
          width: widget.size,
          height: widget.size,
          fit: BoxFit.cover,

          /// Shows a loading spinner while image loads.
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;
            return const Center(child: CircularProgressIndicator());
          },

          /// Fallback UI if image fails to load.
          errorBuilder: (context, error, stackTrace) {
            return _buildPlaceholder();
          },
        ),
      );
    } else {
      /// If no image is provided, show placeholder.
      coverContent = _buildPlaceholder();
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),

        /// Glow effect for currently playing track.
        boxShadow: widget.glow
class MusicCover extends StatelessWidget {
  final double size;
  final bool glow;

  const MusicCover({
    super.key,
    this.size = 250,
    this.glow = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C),
        borderRadius: BorderRadius.circular(16),
        boxShadow: glow
            ? [
                BoxShadow(
                  color: const Color(0xFF1826F8).withOpacity(0.5),
                  blurRadius: 30,
                  spreadRadius: 6,
                )
              ]
            : [],
      ),

      /// Rotation animation wrapper
      child: RotationTransition(
        turns: _rotationController,
        child: coverContent,
      ),
    );
  }

  /// Placeholder UI shown when no album artwork is available.
  Widget _buildPlaceholder() {
    return Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Icon(
        Icons.music_note,
        size: 80,
        color: Colors.white,
      ),
      child: const Icon(Icons.music_note,
          size: 80, color: Colors.white),
    );
  }
}
