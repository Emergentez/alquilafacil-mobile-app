import 'package:alquilafacil/public/presentation/widgets/screen_bottom_app_bar.dart';
import 'package:alquilafacil/public/ui/theme/main_theme.dart';
import 'package:alquilafacil/subscriptions/presentation/provider/subscription_provider.dart';
import 'package:alquilafacil/subscriptions/presentation/widgets/subscription_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubscriptionsManagementScreen extends StatefulWidget {
  const SubscriptionsManagementScreen({super.key});

  @override
  State<SubscriptionsManagementScreen> createState() => _SubscriptionsManagementScreenState();
}

class _SubscriptionsManagementScreenState extends State<SubscriptionsManagementScreen> {

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    final subscriptionProvider = context.read<SubscriptionProvider>();
    () async {
      await subscriptionProvider.getAllSubscriptions();
      setState(() {
        isLoading = false;
      });
    }();
  }

  @override
  Widget build(BuildContext context) {
    final subscriptionProvider = context.watch<SubscriptionProvider>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MainTheme.primary(context),
        foregroundColor: Colors.white,
        title: const Text(
          "Gestión de suscripciones",
        ),
      ),
      body:
            isLoading
              ? const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text("Cargando suscripciones..."),
              ],
            ),
          )
          :Column(
        children: <Widget>[
          Expanded(
            child: ListView.separated(
              padding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              itemBuilder: (BuildContext context, int index) {
                return SubscriptionCard(
                  id: subscriptionProvider.subscriptions[index].id!,
                  voucherImageUrl: subscriptionProvider.subscriptions[index].voucherImageUrl,
                );
              },
              itemCount: subscriptionProvider.subscriptions.length,
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 10);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const ScreenBottomAppBar(),
    );
  }
}
