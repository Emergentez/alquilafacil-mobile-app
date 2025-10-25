import 'package:alquilafacil/public/ui/theme/main_theme.dart';
import 'package:flutter/material.dart';
import 'package:alquilafacil/public/presentation/widgets/navigation_button.dart';

class ScreenBottomAppBar extends StatelessWidget {
  const ScreenBottomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name ?? '';
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
              child: NavigationButton(
            buttonIcon: Icons.search_outlined,
            onNavigate: () =>
                Navigator.pushReplacementNamed(context, '/search-space'),
            iconColor: currentRoute == '/search-space'
                ? MainTheme.background(context)
                : Colors.orangeAccent,
            backgroundColor: currentRoute == '/search-space'
                ? Colors.orangeAccent
                : MainTheme.background(context),
          )),
          Expanded(
              child: NavigationButton(
            buttonIcon: Icons.notifications,
            onNavigate: () =>
                Navigator.pushReplacementNamed(context, '/notifications'),
            iconColor: currentRoute == '/notifications'
                ? MainTheme.background(context)
                : Colors.orangeAccent,
            backgroundColor: currentRoute == '/notifications'
                ? Colors.orangeAccent
                : MainTheme.background(context),
          )),
          Expanded(
              child: NavigationButton(
            buttonIcon: Icons.add,
            onNavigate: () =>
                Navigator.pushReplacementNamed(context, '/tutorial-space'),
            iconColor: currentRoute == '/tutorial-space'
                ? MainTheme.background(context)
                : Colors.orangeAccent,
            backgroundColor: currentRoute == '/tutorial-space'
                ? Colors.orangeAccent
                : MainTheme.background(context),
            size: 60.0,
          )),
          Expanded(
              child: NavigationButton(
            buttonIcon: Icons.calendar_month_outlined,
            onNavigate: () =>
                Navigator.pushReplacementNamed(context, '/calendar'),
            iconColor: currentRoute == '/calendar'
                ? MainTheme.background(context)
                : Colors.orangeAccent,
            backgroundColor: currentRoute == '/calendar'
                ? Colors.orangeAccent
                : MainTheme.background(context),
          )),
          Expanded(
              child: NavigationButton(
            buttonIcon: Icons.person_outline,
            onNavigate: () =>
                Navigator.pushReplacementNamed(context, '/profile'),
            iconColor: currentRoute == '/profile'
                ? MainTheme.background(context)
                : Colors.orangeAccent,
            backgroundColor: currentRoute == '/profile'
                ? Colors.orangeAccent
                : MainTheme.background(context),
          )),
        ],
      ),
    );
  }
}
