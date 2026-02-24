import 'package:flutter/material.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  static const Color primaryBlue = Color(0xFF1826F8);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        title: const Text(
          "Library",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 26,
            color: Colors.black87,
            letterSpacing: .3,
          ),
        ),

        actions: [

          TextButton(
            onPressed: () {},

            child: const Text(
              "Edit",
              style: TextStyle(
                color: primaryBlue,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),

          const SizedBox(width: 10)
        ],
      ),

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

          const Padding(
            padding: EdgeInsets.fromLTRB(
              18,
              30,
              16,
              12,
            ),

            child: Text(
              "Recently Added",

              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),

          /// Album Grid
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

              return Column(

                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  /// Album Card
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

  /// Library Menu Card
  Widget _buildLibraryItem(
      IconData icon,
      String title,
      ){

    return Padding(

      padding:
          const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 4,
      ),

      child: Card(

        elevation: 0,

        color: Colors.white,

        shadowColor: Colors.black12,

        shape:
            RoundedRectangleBorder(

          borderRadius:
              BorderRadius.circular(14),
        ),

        child: InkWell(

          borderRadius:
              BorderRadius.circular(14),

          onTap: () {},

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
    );
  }
}
