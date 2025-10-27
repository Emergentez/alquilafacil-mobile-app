import 'package:alquilafacil/profile/presentation/providers/profile_provider.dart';
import 'package:alquilafacil/public/presentation/widgets/screen_bottom_app_bar.dart';
import 'package:alquilafacil/reservation/presentation/widgets/space_info_actions.dart';
import 'package:alquilafacil/reservation/presentation/widgets/space_info_details.dart';
import 'package:alquilafacil/spaces/presentation/providers/space_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../public/ui/theme/main_theme.dart';
import '../../domain/model/reservation.dart';
import 'payment_screen.dart';

class ReservationDetailsScreen extends StatefulWidget {
  const ReservationDetailsScreen({super.key});
  @override
  State<StatefulWidget> createState() => _ReservationDetailsScreen();
}

class _ReservationDetailsScreen extends State<ReservationDetailsScreen> {
  late Reservation reservation;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    reservation = ModalRoute.of(context)!.settings.arguments as Reservation;
  }

  @override
  void initState() {
    super.initState();
    final spaceProvider = context.read<SpaceProvider>();
    final profileProvider = context.read<ProfileProvider>();
    () async {
      await profileProvider.fetchUsernameExpect(
        spaceProvider.spaceSelected!.userId!,
      );
    }();
  }

  @override
  Widget build(BuildContext context) {
    final spaceProvider = context.watch<SpaceProvider>();
    final profileProvider = context.watch<ProfileProvider>();
    final now = DateTime.now();
    final isActive = now.isAfter(reservation.startDate) && now.isBefore(reservation.endDate);

    return Scaffold(
      backgroundColor: MainTheme.background(context),
      appBar: AppBar(
        backgroundColor: MainTheme.primary(context),
        title: const Text(
          "Información de la reserva",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      bottomNavigationBar: const ScreenBottomAppBar(),
      body: SingleChildScrollView(
        child: spaceProvider.spaceSelected != null
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              spaceProvider.spaceSelected!.photoUrls[0],
              width: double.infinity,
              fit: BoxFit.cover,
              repeat: ImageRepeat.noRepeat,
            ),
            const SizedBox(height: 15),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SpaceInfoDetails(
                    localName: spaceProvider.spaceSelected!.localName,
                    capacity: spaceProvider.spaceSelected!.capacity,
                    username: profileProvider.usernameExpect,
                    description: spaceProvider.spaceSelected!.descriptionMessage,
                    address: spaceProvider.spaceSelected!.address,
                    isEditMode: false,
                    features: spaceProvider.spaceSelected!.features,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Inicia el: ${DateFormat('dd/MM/yyyy').format(reservation.startDate)} a las ${DateFormat('HH:mm').format(reservation.startDate)}",
                    style: TextStyle(
                      color: MainTheme.contrast(context),
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Termina el: ${DateFormat('dd/MM/yyyy').format(reservation.endDate)} a las ${DateFormat('HH:mm').format(reservation.endDate)}",
                    style: TextStyle(
                      color: MainTheme.contrast(context),
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (reservation.endDate.isBefore(now))
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: TextButton(
                        child: const Text(
                          "Deja un comentario",
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () => Navigator.pushNamed(context, "/create-comments"),
                      ),
                    ),
                  const SizedBox(height: 20),
                  if (isActive)
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(MainTheme.secondary(context)),
                        ),
                        child: const Text(
                          "Monitorear estado del local ahora",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/monitoring',
                            arguments: reservation,
                          );
                        },
                      ),
                    ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(MainTheme.primary(context)),
                      ),
                      child: const Text(
                        "Reportar local",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () => Navigator.pushNamed(context, "/create-report"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
            : Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Center(
            child: Text(
              "No hay espacio seleccionado",
              style: TextStyle(
                color: MainTheme.contrast(context),
                fontSize: 20.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
