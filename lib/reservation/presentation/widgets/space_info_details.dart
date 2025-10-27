
import 'package:flutter/cupertino.dart';

import '../../../public/ui/theme/main_theme.dart';

class SpaceInfoDetails extends StatelessWidget {
  final String localName;
  final int capacity;
  final String username;
  final String description;
  final String address;
  final String features;
  final bool isEditMode;

  const SpaceInfoDetails({
    super.key,
    required this.localName,
    required this.capacity,
    required this.username,
    required this.description,
    required this.address,
    required this.isEditMode,
    required this.features,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          localName,
          textAlign: TextAlign.start,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: MainTheme.contrast(context),
              fontSize: 25.0),
        ),
        Text(
          address,
          textAlign: TextAlign.start,
          style: TextStyle(color: MainTheme.contrast(context), fontSize: 18.0),
        ),
        Text(
          "Aforo: $capacity personas",
          textAlign: TextAlign.start,
          style: TextStyle(color: MainTheme.helper(context), fontSize: 15.0),
        ),
        const SizedBox(height: 20),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Propietario: ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: MainTheme.contrast(context),
                  fontSize: 18.0,
                ),
              ),
              TextSpan(
                text: username,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: MainTheme.contrast(context),
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.start,
        ),
        const SizedBox(height: 20),
        Text(
          "Descripción:",
          style: TextStyle(
              color: MainTheme.contrast(context),
              fontWeight: FontWeight.bold,
              fontSize: 17.0),
        ),
        Text(
          description,
          style: TextStyle(color: MainTheme.contrast(context), fontSize: 17.0),
        ),
      ],
    );
  }
}

