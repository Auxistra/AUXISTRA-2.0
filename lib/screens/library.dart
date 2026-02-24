import 'package:flutter/material.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,

      appBar: AppBar(
        title: const Text(
          'Library',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 26,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Edit',
              style: TextStyle(
                color: Color(0xFF1826F8),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 8)
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.only(bottom: 20),
        children: [

          /// Library Menu
          _buildLibraryItem(Icons.playlist_play, 'Playlists'),
          _buildLibraryItem(Icons.music_note, 'Songs'),
          _buildLibraryItem(Icons.album, 'Albums'),
          _buildLibraryItem(Icons.person, 'Artists'),
          _buildLibraryItem(Icons.download_done, 'Downloaded'),

          const Padding(
            padding: EdgeInsets.fromLTRB(16, 30, 16, 12),
            child: Text(
              'Recently Added',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),

          /// Albums Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),

            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 18,
              childAspectRatio: 0.78,
            ),

            itemCount: 4,

            itemBuilder: (context, index) {

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// Album Card
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),

                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF3A3A3A),
                            Color(0xFF1F1F1F),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),

                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.08),
                            blurRadius: 10,
                            offset: const Offset(0, 6),
                          )
                        ],
                      ),

                      child: const Center(
                        child: Icon(
                          Icons.album,
                          size: 58,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Album Name',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 2),

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

  /// Library List Item
  Widget _buildLibraryItem(IconData icon, String title) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),

      child: Card(
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),

        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 14),

          leading: Icon(
            icon,
            color: const Color(0xFF1826F8),
            size: 26,
          ),

          title: Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),

          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Colors.grey,
          ),

          onTap: () {},
        ),
      ),
    );
  }
}
