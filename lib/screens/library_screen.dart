import 'package:flutter/material.dart';

/// LibraryScreen
/// Displays user's music library.
/// Includes:
/// - Library categories
/// Displays the user's music library similar to Apple Music.
/// Includes:
/// - Library categories (Playlists, Songs, Albums, etc.)
/// - Recently added albums grid
class LibraryScreen extends StatelessWidget {

  const LibraryScreen({super.key});

  static const Color primaryBlue = Color(0xFF1826F8);

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xFFF6F7FB),

      /// App Bar
      appBar: AppBar(

        backgroundColor: Colors.transparent,
        elevation: 0,

        title: const Text(
          "Library",

          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 26,
            color: Colors.black87,
          ),
        ),

        actions: [

          /// Edit Button
          TextButton(

            onPressed: () {
              // TODO: Edit functionality
            },

            child: const Text(

              "Edit",

              style: TextStyle(
                color: primaryBlue,
                fontWeight: FontWeight.w600,
              ),
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

          const SizedBox(width: 10),
        ],
      ),

      /// Body
      /// Main scrollable content
      body: ListView(

        padding: const EdgeInsets.only(
          bottom: 24,
          top: 6,
        ),

        children: [

          /// Library Menu
          _buildLibraryItem(Icons.playlist_play,'Playlists'),
          _buildLibraryItem(Icons.music_note,'Songs'),
          _buildLibraryItem(Icons.album,'Albums'),
          _buildLibraryItem(Icons.person,'Artists'),
          _buildLibraryItem(Icons.download_done,'Downloaded'),

          /// Recently Added Title
          const Padding(

            padding:
                EdgeInsets.fromLTRB(
              18,
              30,
              16,
              12,
            ),

            child: Text(

              "Recently Added",

              style: TextStyle(

                fontSize: 22,

                fontWeight:
                    FontWeight.bold,

                color:
                    Colors.black87,
              ),
            ),
          ),

          /// Albums Grid
          GridView.builder(

            shrinkWrap: true,

            physics:
                const NeverScrollableScrollPhysics(),

            padding:
                const EdgeInsets.symmetric(
              horizontal: 16,
            ),

            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(

              crossAxisCount: 2,

              crossAxisSpacing: 16,

              mainAxisSpacing: 18,

              childAspectRatio: .78,
            ),

            itemCount: 4,

            itemBuilder:
                (context,index){

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

                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  /// Album Card
                  /// Album artwork container
                  Expanded(

                    child: Container(

                      decoration:
                          BoxDecoration(

                        borderRadius:
                            BorderRadius.circular(16),

                        gradient:
                            const LinearGradient(

                          colors: [

                            Color(0xFF404040),

                            Color(0xFF1B1B1B),
                          ],

                          begin:
                              Alignment.topLeft,

                          end:
                              Alignment.bottomRight,
                        ),

                        boxShadow: [

                          BoxShadow(

                            color: Colors.black
                                .withOpacity(.08),

                            blurRadius: 12,

                            offset:
                                const Offset(0,6),
                          )
                        ],
                      ),

                      child:
                          const Center(

                        child: Icon(

                          Icons.album,

                          size: 56,

                          color:
                              Colors.white70,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(

                    "Album Name",

                    maxLines: 1,

                    overflow:
                        TextOverflow.ellipsis,

                    style: TextStyle(

                      fontWeight:
                          FontWeight.w600,

                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 3),

                  const Text(

                    "Artist Name",

                    style: TextStyle(

                      color: Colors.grey,

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

  /// Library Item Builder
  Widget _buildLibraryItem(
      IconData icon,
      String title){

    return Padding(

      padding:
          const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 4,
      ),

      child: Card(

        elevation: 0,

        color: Colors.white,

        shape:
            RoundedRectangleBorder(

          borderRadius:
              BorderRadius.circular(14),
        ),

        child: InkWell(

          borderRadius:
              BorderRadius.circular(14),

          onTap: () {
            // TODO Navigation
          },

          child: ListTile(

            contentPadding:
                const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 4,
            ),

            leading: Container(

              padding:
                  const EdgeInsets.all(8),

              decoration:
                  BoxDecoration(

                color:
                    primaryBlue
                        .withOpacity(.08),

                borderRadius:
                    BorderRadius.circular(10),
              ),

              child: Icon(

                icon,

                color: primaryBlue,

                size: 24,
              ),
            ),

            title: Text(

              title,

              style:
                  const TextStyle(

                fontSize: 17,

                fontWeight:
                    FontWeight.w500,
              ),
            ),

            trailing:
                const Icon(

              Icons.arrow_forward_ios,

              size: 16,

              color: Colors.grey,
            ),
          ),
        ),
      ),
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
