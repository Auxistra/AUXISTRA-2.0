import 'package:flutter/material.dart';

class SleepTimerSheet extends StatelessWidget {
  final ValueChanged<Duration> onTimerSet;
  final VoidCallback onCancel;

  const SleepTimerSheet({
    super.key,
    required this.onTimerSet,
    required this.onCancel,
  });

  static void show(
    BuildContext context, {
    required ValueChanged<Duration> onTimerSet,
    required VoidCallback onCancel,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return SleepTimerSheet(
          onTimerSet: onTimerSet,
          onCancel: onCancel,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      decoration: const BoxDecoration(
        color: Color(0xFF1C1C1E),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            /// Handle
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey[700],
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            const Text(
              'Sleep Timer',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 20),

            _timerOption(
              context,
              label: '15 Minutes',
              duration: const Duration(minutes: 15),
            ),

            _timerOption(
              context,
              label: '30 Minutes',
              duration: const Duration(minutes: 30),
            ),

            _timerOption(
              context,
              label: '1 Hour',
              duration: const Duration(hours: 1),
            ),

            _timerOption(
              context,
              label: 'End of Track',
              duration: const Duration(seconds: -1),
            ),

            const SizedBox(height: 12),

            TextButton(
              onPressed: () {
                Navigator.pop(context);
                onCancel();
              },
              child: const Text(
                'Cancel Timer',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _timerOption(
    BuildContext context, {
    required String label,
    required Duration duration,
  }) {
    return ListTile(
      title: Text(label),
      onTap: () {
        Navigator.pop(context);
        onTimerSet(duration);
      },
    );
  }
}
