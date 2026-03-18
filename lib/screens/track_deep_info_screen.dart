// Import Flutter material UI package
import 'package:flutter/material.dart';

// Main screen to display detailed information about a track
class TrackDeepInfoScreen extends StatelessWidget {
  // Track object passed to the screen
  final TrackInfo track;

  const TrackDeepInfoScreen({
    super.key,
    required this.track,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Dark theme background
      backgroundColor: Colors.black,

      // Top AppBar
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0, // Flat design (no shadow)
        title: const Text(
          "Track Info",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
        ),
      ),

      // Scrollable body to avoid overflow
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 32,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ===== Title Section =====

            // Track title
            Text(
              track.title,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            // Artist name
            Text(
              track.artist,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[400],
              ),
            ),

            const SizedBox(height: 40),

            // ===== Core Track Metrics =====

            _InfoBlock(
              label: "Duration",
              value: track.duration,
            ),
            _InfoBlock(
              label: "Release Year",
              value: track.releaseYear,
            ),
            _InfoBlock(
              label: "Album",
              value: track.album,
            ),

            const SizedBox(height: 40),

            // ===== Audio Technical Details =====

            const _SectionHeader(title: "Audio"),
            const SizedBox(height: 16),

            _InfoBlock(
              label: "BPM", // Beats Per Minute
              value: track.bpm,
            ),
            _InfoBlock(
              label: "Key", // Musical key
              value: track.key,
            ),
            _InfoBlock(
              label: "Time Signature",
              value: track.timeSignature,
            ),

            const SizedBox(height: 40),

            // ===== Credits Section =====

            const _SectionHeader(title: "Credits"),
            const SizedBox(height: 16),

            _InfoBlock(
              label: "Producers",
              value: track.producers,
            ),
            _InfoBlock(
              label: "Writers",
              value: track.writers,
            ),
            _InfoBlock(
              label: "Label",
              value: track.label,
            ),
          ],
        ),
      ),
    );
  }
}

// Reusable widget for section headers (e.g., "Audio", "Credits")
class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 14,
        color: Colors.grey[500],
        letterSpacing: 1.2,
      ),
    );
  }
}

// Reusable widget for displaying label-value pairs
class _InfoBlock extends StatelessWidget {
  final String label;
  final String value;

  const _InfoBlock({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label text (uppercase, smaller font)
          Text(
            label.toUpperCase(),
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              letterSpacing: 1.1,
            ),
          ),

          const SizedBox(height: 6),

          // Value text (main content)
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// Data model class representing all track metadata
class TrackInfo {
  final String title;
  final String artist;
  final String duration;
  final String releaseYear;
  final String album;
  final String bpm;
  final String key;
  final String timeSignature;
  final String producers;
  final String writers;
  final String label;

  // Constructor with required fields
  TrackInfo({
    required this.title,
    required this.artist,
    required this.duration,
    required this.releaseYear,
    required this.album,
    required this.bpm,
    required this.key,
    required this.timeSignature,
    required this.producers,
    required this.writers,
    required this.label,
  });
}
