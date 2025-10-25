import 'package:flutter/material.dart';
import 'package:alquilafacil/public/ui/theme/main_theme.dart';

class NavigationButtons extends StatelessWidget {
  final PageController pageController;
  final bool isLastStep;
  final bool canProceed;
  final VoidCallback? onNext; // Añadir el callback

  const NavigationButtons({
    super.key,
    required this.pageController,
    this.isLastStep = false,
    this.canProceed = true,
    this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          OutlinedButton(
            onPressed: () {
              pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
              );
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: MainTheme.primary(context),
                width: 2.0,
              ),
              foregroundColor: Colors.black,
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: Text('Anterior', style: TextStyle(fontSize: 16.0, color: MainTheme.contrast(context))),
          ),
          ElevatedButton(
            onPressed: canProceed
                ? () {
                    if (onNext != null) {
                      onNext!();
                    }
                    if (isLastStep) {
                      Navigator.pushNamed(context, '/');
                    } else {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    }
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: MainTheme.primary(context),
              foregroundColor: Colors.white,
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: Text(
              isLastStep ? 'Finalizar' : 'Siguiente',
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }
}
