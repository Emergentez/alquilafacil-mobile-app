
import 'package:flutter/material.dart';

import '../../../public/ui/theme/main_theme.dart';

class EventTypeIndicator extends StatelessWidget {
  final Color color;
  final String text;

  const EventTypeIndicator({
    super.key,
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.rectangle,
        ),
      ),
      const SizedBox(width: 8.0),
      Flexible(
        child: Text(
          text,
          style: TextStyle(color: MainTheme.contrast(context)),
          overflow: TextOverflow.visible,
        ),
      ),
    ],
    );
  }
}