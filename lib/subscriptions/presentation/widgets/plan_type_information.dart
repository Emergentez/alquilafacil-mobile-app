

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../public/ui/theme/main_theme.dart';
import '../screens/plan_selected_details_screen.dart';

class PlanTypeInformation extends StatelessWidget {
  final String planName;
  final int planPrice;
  final String planService;
  final int planId;
  const PlanTypeInformation({super.key, required this.planName, required this.planPrice, required this.planService, required this.planId});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        color: MainTheme.background(context),
        elevation: 5.0,
        child: InkWell(
          borderRadius: BorderRadius.circular(10.0),
          onTap:  (){
            Navigator.push(context, MaterialPageRoute(builder: (_) => PlanSelectedDetailsScreen(planName: planName, planService: planService, planId: planId, planPrice: planPrice)));
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Image.network(
                        "https://www.supercoloring.com/sites/default/files/fif/2017/05/gold-star-paper-craft.png",
                      width: 50,
                      height: 50,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                            planName,
                          style: TextStyle(
                              fontSize: 20.0,
                              color: MainTheme.contrast(context),
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          child: Text(
                              planService,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12.0,
                              color: MainTheme.helper(context)
                            ),
                          ),
                        ),
                        Text(
                            "Precio: S/.$planPrice",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: MainTheme.contrast(context),
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
