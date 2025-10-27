import 'package:alquilafacil/subscriptions/data/remote/services/niubiz_service_facade.dart';
import 'package:alquilafacil/subscriptions/presentation/screens/niubiz_payment_screen.dart';
import 'package:alquilafacil/subscriptions/presentation/widgets/payment_method_card.dart';
import 'package:flutter/material.dart';

class PaymentMethodNiubiz extends StatelessWidget {
  final int planPrice;
  const PaymentMethodNiubiz({super.key, required this.planPrice});

  @override
  Widget build(BuildContext context) {
    final NiubizServiceFacade niubizService = NiubizServiceFacade();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        PaymentMethodCard(
          paymentLogo:
              "https://spm.org.pe/wp-content/uploads/2024/03/niubiz_2.webp",
          onPaymentStart: () async {
            try {
              final double amount =
                  double.tryParse(planPrice.toString()) ?? 0.0;
              final sessionKey = await niubizService.getSessionKey(
                '456879852', // MerchantId de soles
                amount,
              );

              // Genera un número de pedido único como String
              final purchaseNumber =
                  DateTime.now().millisecondsSinceEpoch.toString();

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NiubizPaymentScreen(
                    sessionKey: sessionKey,
                    merchantId: '456879852',
                    amount: amount,
                    purchaseNumber: purchaseNumber,
                  ),
                ),
              );
            } catch (e, stacktrace) {
              print('Error: $e');
              print('Stacktrace: $stacktrace');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error iniciando pago: $e')),
              );
            }
          },
        ),
      ],
    );
  }
}
