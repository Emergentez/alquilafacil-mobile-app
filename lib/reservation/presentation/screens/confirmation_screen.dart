import 'package:alquilafacil/public/presentation/widgets/screen_bottom_app_bar.dart';
import 'package:flutter/material.dart';

import '../../domain/model/reservation_arguments.dart';

class ConfirmationScreen extends StatelessWidget {

  const ConfirmationScreen({super.key}) : super();

  @override
  Widget build(BuildContext context) {
    final ReservationArguments args = ModalRoute.of(context)!.settings.arguments as ReservationArguments;

    final double hours = args.endTime!.hour - args.startTime!.hour + (args.endTime!.minute - args.startTime!.minute) / 60;
    const double serviceFee = 0.05;

    const bool isPossible = true;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Finalizar reserva'),
        leading: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.orangeAccent,
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
             Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text('Precio por hora:', style: TextStyle(color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold)),
                  Text('\S/. ${args.price.toStringAsFixed(2)}', style: const TextStyle(color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text('Horas reservadas:', style: TextStyle(color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold)),
                  Text(hours.toStringAsFixed(2), style: const TextStyle(color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text('Subtotal:', style: TextStyle(color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold)),
                  Text('\S/. ${(args.price * hours).toStringAsFixed(2)}', style: const TextStyle(color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 16.0),
              const Divider(),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text('Servicio AlquilaFácil:', style: TextStyle(color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold)),
                  Text('\S/. ${(args.price * hours * serviceFee).toStringAsFixed(2)}', style: TextStyle(color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text('Total:', style: TextStyle(color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold)),
                  Text('\S/. ${(args.price * hours * (1 + serviceFee)).toStringAsFixed(2)}', style: TextStyle(color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 16.0),
              FilledButton(
                onPressed: () => {
                  if (isPossible) {
                    Navigator.pushNamed(context, '/payment', )
                  }
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.orangeAccent),
                  minimumSize: WidgetStateProperty.all(const Size(double.infinity, 70.0)),
                  shape: WidgetStateProperty.all(const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0)))),

                ),
                child: const Text('Finalizar reserva'),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const ScreenBottomAppBar(),
    );
  }
}