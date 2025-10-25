import 'package:alquilafacil/public/ui/theme/main_theme.dart';
  import 'package:alquilafacil/spaces/presentation/widgets/navigation_buttons.dart';
  import 'package:flutter/material.dart';

    class RegisterSpaceStep2 extends StatelessWidget {
    final PageController pageController;

    const RegisterSpaceStep2({super.key, required this.pageController});

    @override
    Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Paso 1: Describe tu espacio',
              style: TextStyle(
                  fontSize: 30, fontWeight: FontWeight.bold, color: MainTheme.contrast(context)),
            ),
            const SizedBox(height: 16),
            const Text(
              'En este paso, te preguntaremos qué tipo de propiedad tienes. A continuación, indícanos la ubicación y algunas cosas más.',
              style: TextStyle(
                  color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 16), // Espaciado adicional si es necesario
            Center(
              child: Image.network(
                "https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcQLgRgP9eEF3IC5gSDDHPh5OQCuwoc_0ykCa1r35rw3ibQ5qenx",
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