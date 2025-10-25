import 'package:flutter/material.dart';

class HighlightedCalendarDay extends StatelessWidget {
  final DateTime day;
  final Color color;
  final VoidCallback onTap;

  const HighlightedCalendarDay({
    super.key,
    required this.day,
    required this.color,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          border: Border.all(color: color, width: 1.5),
        ),
        alignment: Alignment.center,
        child: Text(
          '${day.day}',
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
