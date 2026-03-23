import 'package:flutter/material.dart';

class UploadProgressCard extends StatelessWidget {
  final String fileName;
  final double progress; // 0.0 → 1.0
  final bool isCompleted;

  const UploadProgressCard({
    super.key,
    required this.fileName,
    required this.progress,
    this.isCompleted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.cloud_upload, color: Colors.blueAccent),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  fileName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (isCompleted)
                const Icon(Icons.check_circle, color: Colors.green)
            ],
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: progress,
            minHeight: 6,
            backgroundColor: Colors.white12,
            valueColor:
                const AlwaysStoppedAnimation<Color>(Colors.blueAccent),
          ),
          const SizedBox(height: 6),
          Text(
            isCompleted
                ? "Upload Completed"
                : "${(progress * 100).toInt()}% uploaded",
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
