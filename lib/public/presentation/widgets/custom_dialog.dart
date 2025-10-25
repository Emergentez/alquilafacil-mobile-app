import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../ui/theme/main_theme.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String route;
  const CustomDialog({super.key, required this.title, required this.route});

  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      title: Text(
        title,
        style: TextStyle(
            color: MainTheme.contrast(context),
            fontSize: 15.0
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: TextButton(
                child: const Text('Confirmar'),
                onPressed: (){
                  Navigator.pushNamed(context, route);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
