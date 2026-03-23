import 'package:flutter/material.dart';

enum CollaborationStatus { pending, active, completed }

class CollaborationStatusChip extends StatelessWidget {
  final CollaborationStatus status;

  const CollaborationStatusChip({
    super.key,
    required this.status,
  });

  Color get _color {
    switch (status) {
      case CollaborationStatus.pending:
        return Colors.orange;
      case CollaborationStatus.active:
        return Colors.blue;
      case CollaborationStatus.completed:
        return Colors.green;
    }
  }

  String get _label {
    switch (status) {
      case CollaborationStatus.pending:
        return "Pending";
      case CollaborationStatus.active:
        return "Active";
      case CollaborationStatus.completed:
        return "Completed";
    }
  }

  IconData get _icon {
    switch (status) {
      case CollaborationStatus.pending:
        return Icons.hourglass_top;
      case CollaborationStatus.active:
        return Icons.sync;
      case CollaborationStatus.completed:
        return Icons.check_circle;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(_icon, color: _color, size: 16),
      label: Text(
        _label,
        style: TextStyle(
          color: _color,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: _color.withOpacity(0.15),
      shape: StadiumBorder(
        side: BorderSide(color: _color),
      ),
    );
  }
}
