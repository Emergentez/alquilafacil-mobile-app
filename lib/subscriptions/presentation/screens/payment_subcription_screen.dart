import 'package:alquilafacil/auth/presentation/providers/SignInProvider.dart';
import 'package:alquilafacil/auth/presentation/screens/login.dart';
import 'package:alquilafacil/spaces/presentation/screens/search_spaces.dart';
import 'package:alquilafacil/subscriptions/domain/model/subscription.dart';
import 'package:alquilafacil/subscriptions/presentation/provider/subscription_provider.dart';
import 'package:alquilafacil/subscriptions/presentation/screens/payment_finish_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class PaymentSubscription extends StatelessWidget {
  final int planPrice;
  final int planId;
  final String planName;

  const PaymentSubscription ({
    super.key,
    required this.planPrice,
    required this.planId,
    required this.planName,
  });

  @override
  Widget build(BuildContext context) {
    final subscriptionProvider = context.watch<SubscriptionProvider>();
    final signInProvider = context.watch<SignInProvider>();
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Finaliza el pago de tu suscripción'),
      ),
      child: Center(
        child: PaypalCheckoutView(
          sandboxMode: true,
          clientId: "AXyaQ4frJzmFwCRK7Nf6_rm66IzaMoQGtjNIpBKwarHewHArcTHJGob_gJqsp2nQVjB18sA-osj0u_QK",
          secretKey: "EJqS6dK5rnocQ9kCRHCn53kEflRfm5EYdpODk4ipkOAHzx2MtKbuby6di2UcOCtYZRtUs_wN-0LRzYeW",
          transactions: [
            {
              "amount": {
                "total": planPrice.toString(),
                "currency": "USD",
              },
              "description": "Payment for susbscription at $planName.",
              "item_list": {
                "items": [
                  {
                    "name": planName,
                    "quantity": "1",
                    "price": planPrice.toString(),
                    "currency": "USD",
                  }
                ],
              },
            }
          ],
          note: "Contact us for any questions on your order.",
          onSuccess: (Map params) async {
              try{
                await subscriptionProvider.createSubscription(Subscription(planId: planId, userId: signInProvider.userId, voucherImageUrl: ""));
              } finally{
                Navigator.push(context, MaterialPageRoute(builder: (_) => const PaymentFinishScreen()));
              }
          },
          onError: (error) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('Hubo un error al realizar el pago de la suscripción')),
            );
            Navigator.pop(context);
          },
          onCancel: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('Pago de la suscripción cancelado')),
            );
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
