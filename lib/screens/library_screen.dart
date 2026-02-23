import 'package:flutter/material.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Library', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Edit', style: TextStyle(color: Color(0xFF1826F8))),
          ),
        ],
      ),
      body: ListView(
        children: [
          _buildLibraryItem(Icons.playlist_play, 'Playlists'),
          _buildLibraryItem(Icons.music_note, 'Songs'),
          _buildLibraryItem(Icons.album, 'Albums'),
          _buildLibraryItem(Icons.person, 'Artists'),
          _buildLibraryItem(Icons.download_done, 'Downloaded'),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 32, 16, 8),
            child: Text('Recently Added', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.8,
            ),
            itemCount: 4,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF2C2C2C),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(child: Icon(Icons.album, size: 60)),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text('Album Name', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  const Text('Artist Name', style: TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLibraryItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF1826F8)),
      title: Text(title, style: const TextStyle(fontSize: 18)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: () {},
    );
  }
}
