import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../public/ui/theme/main_theme.dart';

class AvatarDetails extends StatelessWidget {
  final String fullName;
  const AvatarDetails({super.key, required this.fullName});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Bienvenido",
            style: TextStyle(
                color: MainTheme.contrast(context),
                fontSize: 26,
                fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(height: 20),
          Text(
            fullName,
            style:  TextStyle(
                color: MainTheme.contrast(context)
            ),
          ),
        ],
      ),
    );
  }
}
