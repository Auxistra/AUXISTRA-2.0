import 'package:flutter/material.dart';

class AudioDeviceSelector extends StatelessWidget {
  final String currentDevice;
  final List<String> devices;
  final ValueChanged<String> onChanged;

  const AudioDeviceSelector({
    super.key,
    required this.currentDevice,
    required this.devices,
    required this.onChanged,
  });

  static void show(
    BuildContext context, {
    required String currentDevice,
    required List<String> devices,
    required ValueChanged<String> onChanged,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return AudioDeviceSelector(
          currentDevice: currentDevice,
          devices: devices,
          onChanged: onChanged,
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
              'Audio Output',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 20),

            ...devices.map(
              (device) => ListTile(
                leading: Icon(
                  device == currentDevice
                      ? Icons.check_circle
                      : Icons.speaker,
                ),

                title: Text(device),

                onTap: () {
                  Navigator.pop(context);
                  onChanged(device);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
