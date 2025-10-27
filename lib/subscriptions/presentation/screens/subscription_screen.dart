import 'package:alquilafacil/public/presentation/widgets/screen_bottom_app_bar.dart';
import 'package:alquilafacil/subscriptions/presentation/widgets/plan_types_available.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../public/ui/theme/main_theme.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MainTheme.primary(context),
        foregroundColor: Colors.white,
        title: const Text(
          "Suscripción",
        ),
      ),
      body: const PlanTypesAvailable(),
      bottomNavigationBar: const ScreenBottomAppBar(),
    );
  }
}
