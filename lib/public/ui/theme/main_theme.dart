import 'package:flutter/material.dart';

class MainTheme {
  static Color primary(BuildContext context) {
    return Theme.of(context).colorScheme.primary;
  }

  static Color secondary(BuildContext context) {
    return Theme.of(context).colorScheme.secondary;
  }

  static Color background(BuildContext context) {
    return Theme.of(context).colorScheme.surface;
  }

  static Color contrast(BuildContext context) {
    return Theme.of(context).colorScheme.onSurface;
  }

  static Color helper(BuildContext context) {
    return Theme.of(context).colorScheme.surfaceContainerHighest;
  }

  static Color transparent = Colors.transparent;

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: Color(0xFFD13333),
      secondary: Colors.orangeAccent,
      surface: Colors.white,
      onSurface: Colors.black,
      surfaceContainerHighest: Colors.grey,
    ),
    textButtonTheme: const TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStatePropertyAll<Color>(Colors.white),
        backgroundColor: MaterialStatePropertyAll<Color>(Colors.orangeAccent),
        shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
      ),
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: Color(0xFFD13333),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFFD13333),
      secondary: Colors.orangeAccent,
      surface: Color(0xFF2B2B2B),
      onSurface: Colors.white,
      surfaceContainerHighest: Colors.grey,
    ),
    textButtonTheme: const TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStatePropertyAll<Color>(Colors.white),
        backgroundColor: MaterialStatePropertyAll<Color>(Colors.orangeAccent),
        shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
      ),
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: Color(0xFFD13333),
    ),
  );
}
