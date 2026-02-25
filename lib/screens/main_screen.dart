import 'package:flutter/material.dart';

// Importing the main tab screens
import 'home_screen.dart';
import 'search_screen.dart';
import 'library_screen.dart';
import 'artist_screen.dart';

/// MainScreen is the root screen after login.
/// It contains the bottom navigation used to switch between
/// Home, Search, Library, and Artist tabs.
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  /// Stores the currently selected tab index
  int _selectedIndex = 0;

  /// List of screens that correspond to each tab
  /// Order must match BottomNavigationBar items
  static const List<Widget> _screens = <Widget>[
    HomeScreen(),
    SearchScreen(),
    LibraryScreen(),
    ArtistScreen(),
  ];

  /// Called when a bottom navigation item is tapped
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update active tab
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Displays the currently selected screen
      body: SafeArea(
        child: _screens[_selectedIndex],
      ),

      /// Bottom Navigation Bar (Main App Navigation)
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // Active tab
        onTap: _onItemTapped, // Tab switch handler

        // Color scheme adapted for dark theme music app
        selectedItemColor: const Color(0xFF1826F8),
        unselectedItemColor: Colors.grey,

        backgroundColor: const Color(0xFF2C2C2C),
        type: BottomNavigationBarType.fixed,

        /// Navigation Items
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.library_music),
            label: 'Library',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Artist',
          ),
        ],
      ),
    );
  }
}
