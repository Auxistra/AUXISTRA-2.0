import 'package:flutter/material.dart';
import 'player_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const CircleAvatar(
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, color: Colors.white),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Listen Now'),
            _buildHorizontalList(context),
            _buildSectionTitle('Recently Played'),
            _buildHorizontalList(context),
            _buildSectionTitle('Made for You'),
            _buildHorizontalList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildHorizontalList(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: 5,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const PlayerScreen(
                    songTitle: 'Midnight Echo',
                    artistName: 'Neon Wave',
                  ),
                ),
              );
            },
            child: Container(
              width: 160,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF2C2C2C),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                      ),
                      child: const Center(child: Icon(Icons.music_note, size: 50)),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Midnight Echo', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('Neon Wave', style: TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
