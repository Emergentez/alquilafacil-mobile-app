import 'package:alquilafacil/public/presentation/widgets/screen_bottom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../public/ui/theme/main_theme.dart';

class PaymentFinishScreen extends StatelessWidget {
  const PaymentFinishScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 250, horizontal: 20),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "Eso es todo!",
                style: TextStyle(
                  color: MainTheme.contrast(context),
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 250,
                child: Text(
                  "Muchas gracias por adquirir tu plan premium!",
                  style: TextStyle(
                      color: MainTheme.contrast(context),
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Container(
                width: 220,
                margin: const EdgeInsets.symmetric(horizontal: 80),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MainTheme.primary(context),
                      foregroundColor: MainTheme.background(context),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                    ),
                    onPressed: (){
                       Navigator.pushNamed(context, "/search-space");
                    },
                    child: const Text("Volver al inicio")
                ),
              )
            ],
        ),
      ),
      bottomNavigationBar: const ScreenBottomAppBar(),
    );
  }
}
