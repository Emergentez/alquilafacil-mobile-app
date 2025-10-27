import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../public/ui/theme/main_theme.dart';

class PaymentMethodCard extends StatelessWidget {
  final String paymentLogo;
  final VoidCallback onPaymentStart;
  const PaymentMethodCard(
      {super.key, required this.paymentLogo, required this.onPaymentStart});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      width: 130,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          onPaymentStart();
        },
        child: Card(
          elevation: 10.0,
          color: Colors.white,
          child: Image.network(
            fit: BoxFit.cover,
            paymentLogo,
            width: 130,
          ),
        ),
      ),
    );
  }
}
