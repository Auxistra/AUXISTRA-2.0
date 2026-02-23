import 'package:flutter/material.dart';

/// LibraryScreen
/// Displays the user's music library similar to Apple Music.
/// Includes:
/// - Library categories (Playlists, Songs, Albums, etc.)
/// - Recently added albums grid
class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Top navigation bar for the Library screen
      appBar: AppBar(
        title: const Text(
          'Library',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
        backgroundColor: Colors.transparent, // Matches dark UI style
        elevation: 0, // Removes shadow for a clean design
        actions: [
          /// Edit button (used for rearranging library items in future)
          TextButton(
            onPressed: () {
              // TODO: Implement edit functionality
            },
            child: const Text(
              'Edit',
              style: TextStyle(color: Color(0xFF1826F8)),
            ),
          ),
        ],
      ),

      /// Main scrollable content
      body: ListView(
        children: [
          /// Library navigation items
          _buildLibraryItem(Icons.playlist_play, 'Playlists'),
          _buildLibraryItem(Icons.music_note, 'Songs'),
          _buildLibraryItem(Icons.album, 'Albums'),
          _buildLibraryItem(Icons.person, 'Artists'),
          _buildLibraryItem(Icons.download_done, 'Downloaded'),

          /// Section title for recently added albums
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 32, 16, 8),
            child: Text(
              'Recently Added',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          /// Grid displaying recently added albums
          GridView.builder(
            shrinkWrap: true, // Allows grid inside ListView
            physics: const NeverScrollableScrollPhysics(), // Prevents nested scrolling
            padding: const EdgeInsets.symmetric(horizontal: 16),

            /// Grid layout configuration
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Two albums per row
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.8, // Controls album card shape
            ),

            itemCount: 4, // Number of albums shown (temporary static data)

            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Album artwork container
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF2C2C2C), // Dark card color
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Icon(Icons.album, size: 60),
                      ),
                    ),
                  ),

                  /// Album name
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Album Name',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),

                  /// Artist name
                  const Text(
                    'Artist Name',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  /// Builds a reusable library menu item
  /// Example: Playlists, Songs, Albums
  Widget _buildLibraryItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(
        icon,
        color: const Color(0xFF1826F8), // Accent color
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 18),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey,
      ),
      onTap: () {
        // TODO: Navigate to the selected library section
      },
    );
  }
}
