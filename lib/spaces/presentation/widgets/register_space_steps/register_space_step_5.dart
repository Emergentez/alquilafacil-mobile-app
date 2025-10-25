import 'package:alquilafacil/spaces/presentation/widgets/navigation_buttons.dart';
import 'package:flutter/material.dart';

import '../../../../public/ui/theme/main_theme.dart';

class RegisterSpaceStep5 extends StatelessWidget {
  final PageController pageController;

  const RegisterSpaceStep5({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                'Paso 2: Haz que tu espacio destaque',
                style: TextStyle(
                    fontSize: 30, fontWeight: FontWeight.bold, color: MainTheme.contrast(context)),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'En este paso, deberás agregar algunas fotos de tu espacio. Luego, deberás crear un título y una descripción.',
              style: TextStyle(
                  color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 16),
            Center(
              child: Image.network(
                "https://i.ibb.co/wBYdn3v/images-removebg-preview-3.png",
                height: 230,
                width: 300,
              ),
            ),
            const SizedBox(height: 16),
            NavigationButtons(pageController: pageController),
          ],
        ),
      ),
    );
  }
}