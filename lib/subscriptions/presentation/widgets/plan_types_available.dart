import 'package:alquilafacil/public/ui/theme/main_theme.dart';
import 'package:alquilafacil/subscriptions/presentation/provider/plan_provider.dart';
import 'package:alquilafacil/subscriptions/presentation/provider/subscription_provider.dart';
import 'package:alquilafacil/subscriptions/presentation/widgets/plan_type_information.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlanTypesAvailable extends StatefulWidget {
  const PlanTypesAvailable({super.key});

  @override
  State<PlanTypesAvailable> createState() => _PlanTypesAvailableState();
}

class _PlanTypesAvailableState extends State<PlanTypesAvailable> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkSubscriptionStatus();
  }

  Future<void> _checkSubscriptionStatus() async {
    final subscriptionProvider = context.read<SubscriptionProvider>();
    await subscriptionProvider.getSubscriptionStatusByUserId();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final planProvider = context.watch<PlanProvider>();
    final subscriptionProvider = context.watch<SubscriptionProvider>();
    final subscriptionStatus = subscriptionProvider.subscriptionStatus;

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (subscriptionStatus == "Active") {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Ya tienes una suscripción activa",
                style: TextStyle(
                  color: MainTheme.contrast(context),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                "Tu plan actual es: ${planProvider.currentPlans[0].name}",
                style: TextStyle(
                  color: MainTheme.contrast(context),
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              Image.network(
                "https://www.supercoloring.com/sites/default/files/fif/2017/05/gold-star-paper-craft.png",
                height: 200,
                width: 200,
              ),
            ],
          ),
        ),
      );
    }

    else if (subscriptionStatus == "Pending") {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Tu voucher será validado para culminar la compra de tu suscripción.",
                style: TextStyle(
                  color: MainTheme.contrast(context),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                "Tu plan es: ${planProvider.currentPlans[0].name}",
                style: TextStyle(
                  color: MainTheme.contrast(context),
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              Image.network(
                "https://www.supercoloring.com/sites/default/files/fif/2017/05/gold-star-paper-craft.png",
                height: 200,
                width: 200,
              ),
            ],
          ),
        ),
      );
    }

   else  {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                    vertical: 40, horizontal: 20),
                child: Text(
                  "Mejora tu estadía:",
                  style: TextStyle(
                    color: MainTheme.contrast(context),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView.builder(
                  itemCount: planProvider.currentPlans.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    final plan = planProvider.currentPlans[index];
                    return PlanTypeInformation(
                      planName: plan.name,
                      planPrice: plan.price,
                      planService: plan.service,
                      planId: plan.id,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
