import 'package:flutter/material.dart';

class StemSettingsScreen extends StatelessWidget {
  const StemSettingsScreen({super.key});

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 28, bottom: 10, left: 4),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 13,
          color: Colors.grey,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget settingsTile({
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
  }) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: Color(0xFF1C1C1E),
      ),
      child: Row(
        children: [

          Icon(icon, size: 22, color: Colors.grey[300]),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: const TextStyle(fontSize: 17),
                ),

                if (subtitle != null)
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[500],
                    ),
                  ),
              ],
            ),
          ),

          if (trailing != null) trailing,
        ],
      ),
    );
  }

  Widget sectionBox(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(children: children),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),

          children: [

            const SizedBox(height: 10),

            const Text(
              'Stems & Remix',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.5,
              ),
            ),

            const SizedBox(height: 24),

            sectionTitle('STEM UPLOADS'),

            sectionBox([

              settingsTile(
                icon: Icons.upload_file_outlined,
                title: 'Upload Stems',
                subtitle: 'Vocals, drums, bass and more',
                trailing: const Icon(Icons.chevron_right),
              ),

              settingsTile(
                icon: Icons.library_music_outlined,
                title: 'Manage Stems',
                trailing: const Icon(Icons.chevron_right),
              ),

            ]),

            sectionTitle('REMIX PERMISSIONS'),

            sectionBox([

              settingsTile(
                icon: Icons.people_outline,
                title: 'Allow Public Remixing',
                trailing: Switch(
                  value: true,
                  onChanged: (v) {},
                ),
              ),

              settingsTile(
                icon: Icons.verified_outlined,
                title: 'Verified Artists Only',
                trailing: Switch(
                  value: false,
                  onChanged: (v) {},
                ),
              ),

              settingsTile(
                icon: Icons.block_outlined,
                title: 'Blocked Users',
                trailing: const Icon(Icons.chevron_right),
              ),

            ]),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
