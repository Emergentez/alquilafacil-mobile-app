import 'package:alquilafacil/public/ui/theme/main_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlanSelectedDetails extends StatelessWidget {
  final String planName;
  final String planService;
  final int id;
  final int planPrice;
  const PlanSelectedDetails({super.key, required this.planName, required this.planService, required this.id, required this.planPrice});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
          elevation: 15.0,
          color: MainTheme.background(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                  "https://www.supercoloring.com/sites/default/files/fif/2017/05/gold-star-paper-craft.png",
                height: 200,
                fit: BoxFit.fitWidth,
                repeat: ImageRepeat.noRepeat,
              ),
               Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      child: Text(
                        "$planName :",
                        style: TextStyle(
                            color: MainTheme.contrast(context),
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text(
                        planService,
                        style: TextStyle(
                            fontSize: 12.0,
                            color: MainTheme.helper(context)
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      child: Text(
                        "Precio total: \$$planPrice",
                        style: TextStyle(
                            color: MainTheme.contrast(context),
                            fontWeight: FontWeight.bold,
                          fontSize: 15.0
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        )
    );
  }
}
