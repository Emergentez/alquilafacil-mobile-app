import 'dart:io';

import 'package:alquilafacil/public/presentation/widgets/custom_dialog.dart';
import 'package:alquilafacil/public/presentation/widgets/screen_bottom_app_bar.dart';
import 'package:alquilafacil/subscriptions/presentation/screens/subscription_payment_screen.dart';
import 'package:alquilafacil/subscriptions/presentation/widgets/plan_selected_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../auth/presentation/providers/SignInProvider.dart';
import '../../../public/ui/theme/main_theme.dart';
import '../../domain/model/subscription.dart';
import '../provider/subscription_provider.dart';

class PlanSelectedDetailsScreen extends StatefulWidget {
  final String planName;
  final String planService;
  final int planId;
  final int planPrice;

  const PlanSelectedDetailsScreen({
    super.key,
    required this.planName,
    required this.planService,
    required this.planId,
    required this.planPrice,
  });

  @override
  State<PlanSelectedDetailsScreen> createState() => _PlanSelectedDetailsScreenState();
}
class _PlanSelectedDetailsScreenState extends State<PlanSelectedDetailsScreen> {
  String bankAccount = "";
  String interbankAccount = "";
  String? _voucherImage;

  Future<void> fetchBankAccount(SubscriptionProvider subscriptionProvider) async {
    final fetchedAccounts = await subscriptionProvider.getAdminBankAccounts();
    setState(() {
      bankAccount = fetchedAccounts[0];
      interbankAccount = fetchedAccounts[1];
    });
  }

  Future<void> _pickVoucherImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final subscriptionProvider = context.read<SubscriptionProvider>();
      await subscriptionProvider.uploadImage(File(pickedFile.path));
      setState(() {
        _voucherImage = subscriptionProvider.subscriptionPhotoUrl;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final subscriptionProvider = Provider.of<SubscriptionProvider>(context, listen: false);
    fetchBankAccount(subscriptionProvider);
  }

  @override
  Widget build(BuildContext context) {
    final subscriptionProvider = context.watch<SubscriptionProvider>();
    final signInProvider = context.read<SignInProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MainTheme.primary(context),
        foregroundColor: Colors.white,
        title: const Text("Compra de suscripción"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  "Para poder realizar la compra del plan, adjunta la foto del voucher de pago.",
                  style: TextStyle(
                      fontSize: 12.0,
                      color: MainTheme.contrast(context),
                      fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "El plan seleccionado es: ${widget.planName}",
                style: TextStyle(
                    fontSize: 14.0, color: MainTheme.helper(context)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                "Precio a pagar: S/.${widget.planPrice}",
                style: const TextStyle(
                    fontSize: 16.0, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                "Puedes realizar el pago a las siguientes cuentas bancarias:",
                style: TextStyle(
                    fontSize: 16.0, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                "Cuenta bancaria: $bankAccount",
                style: const TextStyle(
                    fontSize: 16.0, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                "Cuenta interbancaria: $interbankAccount",
                style: const TextStyle(
                    fontSize: 16.0, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () => _pickVoucherImage(context),
                child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: _voucherImage == null
                      ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_a_photo_outlined,
                          color: MainTheme.primary(context), size: 40),
                      const SizedBox(height: 8),
                      const Text(
                        'Subir voucher de pago',
                        style: TextStyle(
                            color: Colors.grey, fontSize: 16),
                      ),
                    ],
                  )
                      : ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      _voucherImage!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_voucherImage == null) {
                      showDialog(
                        context: context,
                        builder: (context) => const CustomDialog(
                          title: "Debes adjuntar el voucher de pago",
                          route: "/space-info",
                        ),
                      );
                    } else {
                      try {
                        await subscriptionProvider
                            .createSubscription(
                          Subscription(
                            planId: widget.planId,
                            userId: signInProvider.userId,
                            voucherImageUrl: _voucherImage!,
                          ),
                        );
                        showDialog(
                          context: context,
                          builder: (context) => const CustomDialog(
                            title: "Tu solicitud procederá a ser validada",
                            route: "/profile",
                          ),
                        );

                      } catch (e) {
                        showDialog(
                          context: context,
                          builder: (context) => const CustomDialog(
                            title: "Error",
                            route: "/space-info",
                          ),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MainTheme.secondary(context),
                    foregroundColor: MainTheme.background(context),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text("Comprar suscripción"),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const ScreenBottomAppBar(),
    );
  }
}
