import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  final ValueChanged<String> onChanged;

  const SearchBarWidget({super.key, required this.onChanged});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {

  final TextEditingController _controller = TextEditingController();

  void clearText() {
    _controller.clear();
    widget.onChanged("");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),

      child: TextField(
        controller: _controller,
        onChanged: (value) {
          widget.onChanged(value);
          setState(() {});
        },

        style: const TextStyle(color: Colors.white),

        decoration: InputDecoration(
          hintText: "Search songs, artists...",
          hintStyle: const TextStyle(color: Colors.grey),

          filled: true,
          fillColor: const Color(0xFF1A1A1A),

          contentPadding:
              const EdgeInsets.symmetric(vertical: 16),

          prefixIcon: const Icon(
            Icons.search,
            color: Colors.grey,
          ),

          suffixIcon: _controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Colors.grey,
                  ),
                  onPressed: clearText,
                )
              : null,

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
