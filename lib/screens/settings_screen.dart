import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 28,
        bottom: 10,
        left: 4,
      ),
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

          Icon(
            icon,
            size: 22,
            color: Colors.grey[300],
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                  ),
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
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          children: [

            const SizedBox(height: 10),

            /// Header
            const Text(
              'Settings',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.5,
              ),
            ),

            const SizedBox(height: 24),

            /// Account Section
            sectionTitle('ACCOUNT'),

            sectionBox([

              settingsTile(
                icon: Icons.person_outline,
                title: 'Profile',
                subtitle: 'Manage your account',
                trailing: const Icon(Icons.chevron_right),
              ),

              settingsTile(
                icon: Icons.lock_outline,
                title: 'Privacy',
                trailing: const Icon(Icons.chevron_right),
              ),

            ]),

            /// Playback Section
            sectionTitle('PLAYBACK'),

            sectionBox([

              settingsTile(
                icon: Icons.high_quality_outlined,
                title: 'Audio Quality',
                trailing: const Icon(Icons.chevron_right),
              ),

              settingsTile(
                icon: Icons.download_outlined,
                title: 'Downloads',
                trailing: const Icon(Icons.chevron_right),
              ),

              settingsTile(
                icon: Icons.volume_up_outlined,
                title: 'Normalize Volume',
                trailing: Switch(
                  value: true,
                  onChanged: (v) {},
                ),
              ),

            ]),

            /// App Section
            sectionTitle('APP'),

            sectionBox([

              settingsTile(
                icon: Icons.dark_mode_outlined,
                title: 'Dark Mode',
                trailing: Switch(
                  value: true,
                  onChanged: (v) {},
                ),
              ),

              settingsTile(
                icon: Icons.notifications_none,
                title: 'Notifications',
                trailing: const Icon(Icons.chevron_right),
              ),

            ]),

            const SizedBox(height: 40),

            /// Sign Out
            Center(
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Sign Out',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.red,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
