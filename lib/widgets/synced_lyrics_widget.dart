import 'package:flutter/material.dart';

class SyncedLyricsWidget extends StatefulWidget {
  final Duration position;
  final List<LyricLine> lyrics;

  const SyncedLyricsWidget({
    super.key,
    required this.position,
    required this.lyrics,
  });

  @override
  State<SyncedLyricsWidget> createState() =>
      _SyncedLyricsWidgetState();
}

class _SyncedLyricsWidgetState
    extends State<SyncedLyricsWidget> {
  final ScrollController _scrollController = ScrollController();

  int _currentLineIndex = 0;

  @override
  void didUpdateWidget(covariant SyncedLyricsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateActiveLine();
  }

  void _updateActiveLine() {
    for (int i = 0; i < widget.lyrics.length; i++) {
      final line = widget.lyrics[i];

      if (widget.position >= line.start &&
          (i == widget.lyrics.length - 1 ||
              widget.position < widget.lyrics[i + 1].start)) {
        if (_currentLineIndex != i) {
          _currentLineIndex = i;
          _scrollToActiveLine();
        }
        break;
      }
    }
  }

  void _scrollToActiveLine() {
    const lineHeight = 60.0;
    final offset =
        (_currentLineIndex * lineHeight) - 200;

    _scrollController.animateTo(
      offset.clamp(
        0,
        _scrollController.position.maxScrollExtent,
      ),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 40,
      ),
      itemCount: widget.lyrics.length,
      itemBuilder: (context, index) {
        final line = widget.lyrics[index];
        final isActive = index == _currentLineIndex;

        return SizedBox(
          height: 60,
          child: _SyncedLine(
            line: line,
            position: widget.position,
            isActive: isActive,
          ),
        );
      },
    );
  }
}

class _SyncedLine extends StatelessWidget {
  final LyricLine line;
  final Duration position;
  final bool isActive;

  const _SyncedLine({
    required this.line,
    required this.position,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: line.words.map((word) {
        final isWordActive =
            position >= word.start;

        return AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 150),
          style: TextStyle(
            fontSize: isActive ? 24 : 20,
            fontWeight: FontWeight.w600,
            color: isWordActive
                ? Colors.white
                : Colors.grey[600],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 4,
            ),
            child: Text(word.text),
          ),
        );
      }).toList(),
    );
  }
}

class LyricLine {
  final Duration start;
  final List<LyricWord> words;

  LyricLine({
    required this.start,
    required this.words,
  });
}

class LyricWord {
  final String text;
  final Duration start;

  LyricWord({
    required this.text,
    required this.start,
  });
}
