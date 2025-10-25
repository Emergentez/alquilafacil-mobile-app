import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget{
  final IconData buttonIcon;
  final VoidCallback onNavigate;
  final Color backgroundColor;
  final Color iconColor;
  final double size;

  const NavigationButton({
    super.key,
    required this.buttonIcon,
    required this.onNavigate,
    required this.iconColor,
    required this.backgroundColor,
    this.size = 45.0
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle
      ),
      child: IconButton(
        onPressed: onNavigate,
        icon: Icon(
          buttonIcon,
          color: iconColor,
        ),
      )
    );
  }

}