import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../public/presentation/widgets/custom_dialog.dart';
import '../../../public/ui/providers/theme_provider.dart';
import '../../../public/ui/theme/main_theme.dart';
import '../provider/subscription_provider.dart';

class SubscriptionCard extends StatefulWidget {
  final int id;
  final String voucherImageUrl;

  const SubscriptionCard({
    super.key,
    required this.id,
    required this.voucherImageUrl,
  });

  @override
  _SubscriptionCardState createState() => _SubscriptionCardState();
}

class _SubscriptionCardState extends State<SubscriptionCard> {

  bool isActive = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final subscriptionProvider = context.watch<SubscriptionProvider>();

    return  Card(
        color: themeProvider.isDarkTheme ? MainTheme.primary(context) : Colors.white,
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(15.0),
              ),
              child: Image.network(
                widget.voucherImageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 180,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: isActive
                      ? null
                      : () async {
                    try {
                      await subscriptionProvider.activeSubscription(widget.id);
                      setState(() {
                        isActive = true;
                      });
                    } catch (e) {
                      await showDialog(
                        context: context,
                        builder: (_) => const CustomDialog(
                          title: "Error al activar suscripción",
                          route: "/profile",
                        ),
                      );
                    }
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: isActive
                        ? Colors.grey[300]
                        :  MainTheme.secondary(context),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    isActive ? 'Suscripción activa' : 'Activar suscripción',
                    style: TextStyle(
                      color: isActive
                          ? Colors.grey
                          :  Colors.white,
                    ),
                  ),
                ),
              ]
            ),
          ]
        ),
      );
  }
}