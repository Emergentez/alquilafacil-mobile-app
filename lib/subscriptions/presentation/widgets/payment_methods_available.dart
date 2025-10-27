import 'package:alquilafacil/subscriptions/presentation/provider/plan_provider.dart';
import 'package:alquilafacil/subscriptions/presentation/screens/payment_subcription_screen.dart';
import 'package:alquilafacil/subscriptions/presentation/widgets/payment_method_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentMethodsAvailable extends StatelessWidget {
  const PaymentMethodsAvailable({super.key});

  @override
  Widget build(BuildContext context) {
    final planProvider = context.watch<PlanProvider>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        PaymentMethodCard(
            paymentLogo:
                "https://logodownload.org/wp-content/uploads/2014/10/paypal-logo-0.png",
            onPaymentStart: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => PaymentSubscription(
                          planPrice: planProvider.currentPlans[0].price,
                          planId: planProvider.currentPlans[0].id,
                          planName: planProvider.currentPlans[0].name)));
            }),
      ],
    );
  }
}
