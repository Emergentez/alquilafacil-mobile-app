import 'package:alquilafacil/notification/presentation/providers/notification_provider.dart';
import 'package:alquilafacil/spaces/presentation/screens/search_spaces.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../../../public/presentation/widgets/custom_dialog.dart';
import '../providers/reservation_provider.dart';

class PaymentScreen extends StatelessWidget {
  final double amount;
  final String startDate;
  final String endDate;
  final String localName;
  final int userId;
  final int localId;

  const PaymentScreen({
    super.key,
    required this.amount,
    required this.startDate,
    required this.endDate,
    required this.localName,
    required this.userId,
    required this.localId,
  });

  @override
  Widget build(BuildContext context) {
    final  reservationProvider = context.watch<ReservationProvider>();
    final notificationProvider = context.watch<NotificationProvider>();
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Finaliza el pago de tu reserva'),
      ),
      child: Center(
        child: PaypalCheckoutView(
          sandboxMode: true,
          clientId: "AXyaQ4frJzmFwCRK7Nf6_rm66IzaMoQGtjNIpBKwarHewHArcTHJGob_gJqsp2nQVjB18sA-osj0u_QK",
          secretKey: "EJqS6dK5rnocQ9kCRHCn53kEflRfm5EYdpODk4ipkOAHzx2MtKbuby6di2UcOCtYZRtUs_wN-0LRzYeW", // Replace with your actual secret key
          transactions: [
            {
              "amount": {
                "total": amount.toString(),
                "currency": "USD",
              },
              "description": "Payment for reservation at $localName from $startDate to $endDate.",
              "item_list": {
                "items": [
                  {
                    "name": localName,
                    "quantity": "1",
                    "price": amount.toString(),
                    "currency": "USD",
                  }
                ],
              },
            }
          ],
          note: "Contact us for any questions on your order.",
          onSuccess: (Map params) async {
            Logger().i("Payment Success: $params");
            try {
                //await reservationProvider.createReservation(userId, localId, startDate, endDate);
                await showDialog(context: context, builder: (_) => const CustomDialog(title: "Reserva realizada con éxito", route:"/search-space"));
            } on DioException catch (e) {
              Logger().e("Error while creating reservation: $e");
              if(e.response!.statusCode == 400){
                await showDialog(context: context, builder: (_) => const CustomDialog(title: "No puedes reservar tu mismo espacio", route:"/search-space"));
              }else{
                await showDialog(context: context, builder: (_) => const CustomDialog(title: "Hubo un error al realizar la reserva, por favor revisa los datos proporcionados de tu cuenta", route:"/search-space"));
              }
            }

            try {
              await notificationProvider.createNotification(
                "Reserva realizada al espacio $localName",
                "Uno de tus espacios acaba de ser reservado",
                userId,
              );
            } catch (e) {
              Logger().e("Error while creating notification: $e");
            }


          },
          onError: (error) {
            Logger().e("Payment Error: $error");
            Navigator.pop(context);
          },
          onCancel: () {
            Logger().w("Payment Canceled");
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
