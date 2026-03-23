// Import Flutter Material UI package
import 'package:flutter/material.dart';

// Stateful widget for Stem & Remix settings screen
class StemSettingsScreen extends StatefulWidget {
  const StemSettingsScreen({super.key});

  @override
  State<StemSettingsScreen> createState() => _StemSettingsScreenState();
}

class _StemSettingsScreenState extends State<StemSettingsScreen> {
  // Toggle: Allow public users to remix tracks
  bool _allowPublicRemixing = true;

  // Toggle: Restrict remixing to verified artists only
  bool _verifiedArtistsOnly = false;

  @override
  Widget build(BuildContext context) {
    // Access current theme (not heavily used but good practice)
    final theme = Theme.of(context);

    return Scaffold(
      // Dark theme background
      backgroundColor: Colors.black,

      // App bar configuration
      appBar: AppBar(
        title: const Text(
          'Stems & Remix',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: false,
      ),

      // Main scrollable content
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          const SizedBox(height: 10),

          // ===== STEM UPLOAD SECTION =====
          _buildSectionTitle('STEM UPLOADS'),
          _buildSectionBox([
            _buildSettingsTile(
              icon: Icons.upload_file_rounded,
              title: 'Upload Stems',
              subtitle: 'Vocals, drums, bass and more',
              onTap: () => _showFeedback(context, 'Opening File Picker...'),
              trailing: const Icon(Icons.chevron_right, color: Colors.grey),
            ),

            // Divider between items
            const Divider(height: 1, indent: 54, color: Colors.white10),

            _buildSettingsTile(
              icon: Icons.library_music_rounded,
              title: 'Manage Stems',
              onTap: () => _showFeedback(context, 'Loading Stem Library...'),
              trailing: const Icon(Icons.chevron_right, color: Colors.grey),
            ),
          ]),

          // ===== REMIX PERMISSIONS SECTION =====
          _buildSectionTitle('REMIX PERMISSIONS'),
          _buildSectionBox([
            _buildSettingsTile(
              icon: Icons.people_alt_rounded,
              title: 'Allow Public Remixing',

              // Switch toggle for enabling/disabling public remixing
              trailing: Switch.adaptive(
                value: _allowPublicRemixing,
                activeColor: const Color(0xFF1826F8),
                onChanged: (v) => setState(() => _allowPublicRemixing = v),
              ),
            ),

            const Divider(height: 1, indent: 54, color: Colors.white10),

            _buildSettingsTile(
              icon: Icons.verified_user_rounded,
              title: 'Verified Artists Only',

              // Switch toggle for restricting remixing to verified users
              trailing: Switch.adaptive(
                value: _verifiedArtistsOnly,
                activeColor: const Color(0xFF1826F8),
                onChanged: (v) => setState(() => _verifiedArtistsOnly = v),
              ),
            ),

            const Divider(height: 1, indent: 54, color: Colors.white10),

            _buildSettingsTile(
              icon: Icons.block_flipped,
              title: 'Blocked Users',

              // Opens blocked users list (currently mocked)
              onTap: () => _showFeedback(context, 'Opening Block List...'),
              trailing: const Icon(Icons.chevron_right, color: Colors.grey),
            ),
          ]),

          const SizedBox(height: 40),

          // Informational text about remixing
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              'Remixing allows other users to purchase the rights to use your individual tracks in their own projects.',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 13,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  // Displays a temporary feedback message using SnackBar
  void _showFeedback(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF1C1C1E),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  // Builds section title (e.g., "STEM UPLOADS")
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 8, left: 12),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey.shade500,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.1,
        ),
      ),
    );
  }

  // Reusable settings tile widget
  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        onTap: onTap,

        // Leading icon with styled container
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 20, color: Colors.white),
        ),

        // Main title text
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),

        // Optional subtitle
        subtitle: subtitle != null
            ? Text(
                subtitle,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade500,
                ),
              )
            : null,

        // Trailing widget (icon or switch)
        trailing: trailing,

        // Spacing inside tile
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      ),
    );
  }

  // Container wrapper for grouping tiles into a section box
  Widget _buildSectionBox(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(children: children),
    );
  }
}
