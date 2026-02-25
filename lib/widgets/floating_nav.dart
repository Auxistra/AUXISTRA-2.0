import 'package:flutter/material.dart';

class FloatingNav extends StatefulWidget {
  const FloatingNav({super.key});

  @override
  State<FloatingNav> createState() => _FloatingNavState();
}

class _FloatingNavState extends State<FloatingNav> {
  int selectedIndex = 0;

  final List<IconData> icons = [
    Icons.home,
    Icons.search,
    Icons.favorite,
    Icons.person,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 10)
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(icons.length, (index) {
          return GestureDetector(
            onTap: () {
              setState(() => selectedIndex = index);
            },
            child: Icon(
              icons[index],
              color: selectedIndex == index
                  ? Colors.blue
                  : Colors.white54,
            ),
          );
        }),
      ),
    );
  }
}
