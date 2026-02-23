import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Artists, Songs, Lyrics, and More',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: const Color(0xFF2C2C2C),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.5,
                ),
                itemCount: 8,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF2C2C2C),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(child: Text('Category', style: TextStyle(fontWeight: FontWeight.bold))),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
