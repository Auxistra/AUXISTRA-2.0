import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {

  final ValueChanged<String> onChanged;

  const SearchBarWidget({
    super.key,
    required this.onChanged,
  });

  @override
  State<SearchBarWidget> createState()
      => _SearchBarWidgetState();
}

class _SearchBarWidgetState
    extends State<SearchBarWidget> {

  final TextEditingController controller =
      TextEditingController();

  bool isFocused = false;

  @override
  Widget build(BuildContext context) {

    return Focus(

      onFocusChange: (value) {
        setState(() => isFocused = value);
      },

      child: AnimatedContainer(

        duration:
            const Duration(milliseconds: 250),

        decoration: BoxDecoration(

          borderRadius:
              BorderRadius.circular(16),

          boxShadow: [

            if (isFocused)
              const BoxShadow(
                color: Colors.blueAccent,
                blurRadius: 12,
                spreadRadius: -6,
              ),
          ],
        ),

        child: TextField(

          controller: controller,

          onChanged: widget.onChanged,

          decoration: InputDecoration(

            hintText:
                "Search songs, artists...",

            hintStyle: TextStyle(
              color: Colors.grey[500],
            ),

            filled: true,

            fillColor:
                const Color(0xFF1A1A1A),

            contentPadding:
                const EdgeInsets.symmetric(
              vertical: 16,
            ),

            prefixIcon: const Icon(
              Icons.search,
              color: Colors.grey,
            ),

            /// Clear button appears when typing
            suffixIcon:
                controller.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          controller.clear();
                          widget.onChanged("");
                          setState(() {});
                        },
                      )
                    : null,

            border: OutlineInputBorder(

              borderRadius:
                  BorderRadius.circular(
                      16),

              borderSide:
                  BorderSide.none,
            ),
          ),

          onChanged: (value) {

            widget.onChanged(value);

            setState(() {});
          },
        ),
      ),
    );
  }
}
