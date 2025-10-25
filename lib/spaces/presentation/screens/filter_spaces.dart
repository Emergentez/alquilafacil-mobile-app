import 'package:alquilafacil/public/presentation/widgets/screen_bottom_app_bar.dart';
import 'package:alquilafacil/public/ui/theme/main_theme.dart';
import 'package:alquilafacil/spaces/presentation/widgets/search_space_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../public/ui/providers/theme_provider.dart';

class FilterSpaces extends StatelessWidget {
  const FilterSpaces({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeProvider.isDarkTheme ? MainTheme.primary(context) : MainTheme.background(context),
        title:  Text(
            "Realizar búsqueda",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: MainTheme.contrast(context), fontSize: 20),

        ),
      ),
      backgroundColor: MainTheme.background(context),
      bottomNavigationBar: const ScreenBottomAppBar(),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              SearchSpaceButton(
                suffixIcon: Icons.close,
              )
            ],
          ),
        ),
      ),
    );
  }
}
