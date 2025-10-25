
import 'package:flutter/material.dart';

import '../../ui/theme/main_theme.dart';

class DefaultCalendarDay extends StatelessWidget {
  final DateTime day;
  final bool isOutside;

  const DefaultCalendarDay({
    super.key,
    required this.day,
    this.isOutside = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 0.5),
        color: Colors.transparent,
      ),
      alignment: Alignment.center,
      child: Text(
        '${day.day}',
        style: TextStyle(color: isOutside ? Colors.grey : MainTheme.contrast(context)),
      ),
    );
  }
}
