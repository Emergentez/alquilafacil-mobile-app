import 'package:flutter/material.dart';

class ReservationFailedScreen extends StatelessWidget {

    const ReservationFailedScreen({super.key});

    @override
    Widget build(BuildContext context) {
      return const Scaffold(
        body: Center(
          child: Text('¡Reserva fallida!'),
        ),
      );
    }
}