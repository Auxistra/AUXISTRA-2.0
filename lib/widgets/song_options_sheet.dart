import 'package:flutter/material.dart';

class SongOptionsSheet extends StatelessWidget {
  final String title;
  final String artist;

  final VoidCallback onAddToLibrary;
  final VoidCallback onAddToPlaylist;
  final VoidCallback onDownload;
  final VoidCallback onShare;
  final VoidCallback onViewArtist;
  final VoidCallback onViewAlbum;

  const SongOptionsSheet({
    super.key,
    required this.title,
    required this.artist,
    required this.onAddToLibrary,
    required this.onAddToPlaylist,
    required this.onDownload,
    required this.onShare,
    required this.onViewArtist,
    required this.onViewAlbum,
  });

  static void show(
    BuildContext context, {
    required String title,
    required String artist,
    required VoidCallback onAddToLibrary,
    required VoidCallback onAddToPlaylist,
    required VoidCallback onDownload,
    required VoidCallback onShare,
    required VoidCallback onViewArtist,
    required VoidCallback onViewAlbum,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,

      builder: (_) {
        return SongOptionsSheet(
          title: title,
          artist: artist,
          onAddToLibrary: onAddToLibrary,
          onAddToPlaylist: onAddToPlaylist,
          onDownload: onDownload,
          onShare: onShare,
          onViewArtist: onViewArtist,
          onViewAlbum: onViewAlbum,
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

            /// Song Info
            Column(
              children: [

                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  artist,
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 14,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            _optionTile(
              icon: Icons.library_add_outlined,
              text: 'Add to Library',
              onTap: onAddToLibrary,
            ),

            _optionTile(
              icon: Icons.playlist_add,
              text: 'Add to Playlist',
              onTap: onAddToPlaylist,
            ),

            _optionTile(
              icon: Icons.download_outlined,
              text: 'Download',
              onTap: onDownload,
            ),

            _optionTile(
              icon: Icons.person_outline,
              text: 'View Artist',
              onTap: onViewArtist,
            ),

            _optionTile(
              icon: Icons.album_outlined,
              text: 'View Album',
              onTap: onViewAlbum,
            ),

            _optionTile(
              icon: Icons.share_outlined,
              text: 'Share',
              onTap: onShare,
            ),
          ],
        ),
      ),
    );
  }

  Widget _optionTile({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,

      leading: Icon(
        icon,
        size: 22,
      ),

      title: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
        ),
      ),

      onTap: () {
        Navigator.pop(context);
        onTap();
      },
    );
  }
}
