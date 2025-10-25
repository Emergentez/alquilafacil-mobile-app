import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../public/presentation/widgets/screen_bottom_app_bar.dart';
import '../../../public/ui/providers/theme_provider.dart';
import '../../../public/ui/theme/main_theme.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});
  static String phoneNumber = '+51991042243';
  static String message = 'Hola, necesito ayuda para utilizar AlquilaFacil';

  Future<void> launchWhatsApp() async {
    final encodedMessage = Uri.encodeComponent(message);
    final url = Uri.parse('https://wa.me/$phoneNumber?text=$encodedMessage');

    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw Exception("Cannot launch WhatsApp");
      }
    } catch (e) {
      throw Exception("Error launching WhatsApp: $e");
    }
  }

  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: MainTheme.background(context),
      appBar: AppBar(
        backgroundColor: themeProvider.isDarkTheme ? MainTheme.primary(context) : MainTheme.background(context),
        title: Text(
          'Panel de control',
          style: TextStyle(color: MainTheme.contrast(context)),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.popAndPushNamed(context, '/search-space');
          },
        ),
      ),
      bottomNavigationBar: const ScreenBottomAppBar(),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(16.0),
            elevation: 10.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const NavigationRow(
                    title: 'Preguntas frecuentes',
                    routeName: '/faqs',
                  ),
                  const Divider(),
                  NavigationRow(
                    title: 'Escribir a soporte',
                    routeName: '/',
                    onTap: () async{
                        await launchWhatsApp();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class NavigationRow extends StatelessWidget {
  final String title;
  final String routeName;
  final VoidCallback? onTap;

  const NavigationRow({
    super.key,
    required this.title,
    required this.routeName,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () => Navigator.pushNamed(context, routeName),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: MainTheme.contrast(context),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: MainTheme.contrast(context),
            ),
          ],
        ),
      ),
    );
  }
}
