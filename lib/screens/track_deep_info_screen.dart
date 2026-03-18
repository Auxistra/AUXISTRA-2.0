import 'package:flutter/material.dart';

class TrackDeepInfoScreen extends StatelessWidget {
  final TrackInfo track;

  const TrackDeepInfoScreen({
    super.key,
    required this.track,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "Track Info",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 32,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Title Section
            Text(
              track.title,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              track.artist,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[400],
              ),
            ),

            const SizedBox(height: 40),

            // Core Metrics
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

            // Audio Details
            const _SectionHeader(title: "Audio"),
            const SizedBox(height: 16),

            _InfoBlock(
              label: "BPM",
              value: track.bpm,
            ),
            _InfoBlock(
              label: "Key",
              value: track.key,
            ),
            _InfoBlock(
              label: "Time Signature",
              value: track.timeSignature,
            ),

            const SizedBox(height: 40),

            // Credits
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
          Text(
            label.toUpperCase(),
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: 6),
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
