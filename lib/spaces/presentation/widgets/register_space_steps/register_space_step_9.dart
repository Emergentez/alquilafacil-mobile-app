import 'package:alquilafacil/public/ui/theme/main_theme.dart';
import 'package:alquilafacil/spaces/presentation/widgets/navigation_buttons.dart';
import 'package:flutter/material.dart';

class RegisterSpaceStep9 extends StatelessWidget {
  final PageController pageController;
  final int localCategoryId;
  final String country;
  final String city;
  final String district;
  final String street;
  final String photoUrl;
  final String localName;
  final String descriptionMessage;
  final String capacity;
  final String features;
  final int price;
  final VoidCallback onFinish;

  const RegisterSpaceStep9({
    super.key,
    required this.pageController,
    required this.localCategoryId,
    required this.country,
    required this.city,
    required this.district,
    required this.street,
    required this.photoUrl,
    required this.localName,
    required this.descriptionMessage,
    required this.capacity,
    required this.features,
    required this.price,
    required this.onFinish,
  });

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
                '¡Eso es todo!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: MainTheme.contrast(context),
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Esto es lo que verán los demás.',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.normal,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 32),
            Center(
              child: Container(
                width: 300,
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 1,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            photoUrl,
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const Positioned(
                          top: 8,
                          right: 8,
                          child: Icon(
                            Icons.favorite_border,
                            color: Colors.black,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      localName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$district, $city, $country',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'S/.$price por hora',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Descripción: $descriptionMessage',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Capacidad: $capacity personas',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            NavigationButtons(
              pageController: pageController,
              isLastStep: true,
              onNext: onFinish,
            ),
          ],
        ),
      ),
    );
  }
}
