import 'package:alquilafacil/public/presentation/widgets/screen_bottom_app_bar.dart';
import 'package:alquilafacil/subscriptions/presentation/widgets/payment_method_niubiz.dart';
import 'package:alquilafacil/subscriptions/presentation/widgets/payment_methods_available.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../public/ui/theme/main_theme.dart';

class SubscriptionPaymentScreen extends StatelessWidget {
  final int planPrice;
  const SubscriptionPaymentScreen({super.key, required this.planPrice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MainTheme.primary(context),
        foregroundColor: Colors.white,
        title: const Text(
          "Pago de suscripción",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Precio total: \$$planPrice",
              style: TextStyle(
                  color: MainTheme.contrast(context),
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const PaymentMethodsAvailable(),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const ScreenBottomAppBar(),
    );
  }
}
