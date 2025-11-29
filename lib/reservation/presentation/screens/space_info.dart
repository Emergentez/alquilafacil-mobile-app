import 'dart:io';
import 'dart:ui';

import 'package:alquilafacil/auth/presentation/providers/SignInProvider.dart';
import 'package:alquilafacil/profile/presentation/providers/profile_provider.dart';
import 'package:alquilafacil/public/presentation/widgets/screen_bottom_app_bar.dart';
import 'package:alquilafacil/reservation/presentation/providers/reservation_provider.dart';
import 'package:alquilafacil/reservation/presentation/widgets/space_info_actions.dart';
import 'package:alquilafacil/reservation/presentation/widgets/space_info_details.dart';
import 'package:alquilafacil/spaces/data/remote/helpers/space_service_helper.dart';
import 'package:alquilafacil/spaces/data/remote/services/spaces_service.dart';
import 'package:alquilafacil/spaces/presentation/providers/space_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import '../../../public/presentation/widgets/custom_dialog.dart';
import '../../../public/ui/theme/main_theme.dart';
import 'payment_screen.dart';

class SpaceInfo extends StatefulWidget {
  const SpaceInfo({super.key});
  @override
  State<StatefulWidget> createState() => _SpaceInfoState();
}

class _SpaceInfoState extends State<SpaceInfo> {
  DateTime? _startDateTime;
  DateTime? _endDateTime;
  String? _voucherImage; // Para almacenar la imagen del voucher
  double _totalPrice = 0.0; // Para almacenar el precio total
  int _mainPhotoIndex = 0;

  final double pricePerHour = 20.0; // Supongamos que el precio por hora es 20.0

  // Método para calcular el precio
  void _calculatePrice() {
    if (_startDateTime != null && _endDateTime != null) {
      Duration duration = _endDateTime!.difference(_startDateTime!);
      // Aseguramos que el valor sea positivo, y calculamos el precio
      if (duration.isNegative) {
        _totalPrice =
        0.0; // Si la fecha de inicio es después de la fecha de fin, el precio es 0
      } else {
        // Calculamos el precio en función de las horas
        _totalPrice = duration.inHours * pricePerHour;
      }
    }
  }

  // Método para seleccionar la imagen del voucher
  Future<void> _pickVoucherImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery);
    if (pickedFile != null) {
      final reservationProvider = context.read<ReservationProvider>();
      await reservationProvider.uploadImage(File(pickedFile.path));
      setState(() {
        _voucherImage = reservationProvider.reservationPhotoUrl;
      });
    }
  }

  Future<void> _showDatePicker(BuildContext context, bool isStartDate) async {
    DateTime currentDateTime = DateTime.now();
    DateTime initialDate = isStartDate ? (_startDateTime ?? currentDateTime) : (_endDateTime ?? currentDateTime);
    DateTime lastDate = DateTime(currentDateTime.year + 1, currentDateTime.month, currentDateTime.day);
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: currentDateTime,
      lastDate: lastDate,
    );

    if (selectedDate != null) {
      final TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDate),
      );

      if (selectedTime != null) {
        DateTime finalDateTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );

        setState(() {
          if (isStartDate) {
            _startDateTime = finalDateTime;
          } else {
            _endDateTime = finalDateTime;
          }
          _calculatePrice();
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    final spaceProvider = context.watch<SpaceProvider>();
    final profileProvider = context.watch<ProfileProvider>();
    final signInProvider = context.watch<SignInProvider>();
    final reservationProvider = context.watch<ReservationProvider>();
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
        backgroundColor: MainTheme.background(context),
        appBar: AppBar(
          backgroundColor: MainTheme.primary(context),
          title: Text(
            l10n.spaceInfo,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        bottomNavigationBar: const ScreenBottomAppBar(),
        body: SingleChildScrollView(
          child: spaceProvider.spaceSelected != null
            ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Imagen principal (dinámica)
                  Image.network(
                    spaceProvider.spaceSelected!.photoUrls[_mainPhotoIndex],
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 10),

                  // Mini galería (solo si hay más de 1 imagen)
                  if (spaceProvider.spaceSelected!.photoUrls.length > 1)
                    SizedBox(
                      height: 80,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: spaceProvider.spaceSelected!.photoUrls.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _mainPhotoIndex = index;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: _mainPhotoIndex == index
                                      ? Colors.orangeAccent
                                      : Colors.transparent,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  spaceProvider.spaceSelected!.photoUrls[index],
                                  width: 100,
                                  height: 70,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 15),
              Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SpaceInfoDetails(
                      localName: spaceProvider.spaceSelected!.localName,
                      capacity: spaceProvider.spaceSelected!.capacity,
                      username: profileProvider.usernameExpect,
                      description: spaceProvider.spaceSelected!
                          .descriptionMessage,
                      address: spaceProvider.spaceSelected!.address,
                      isEditMode: false,
                      features: spaceProvider.spaceSelected!.features,
                    ),
                    const SizedBox(height: 20),
                    const SpaceInfoActions(),
                    const SizedBox(height: 20),
                    Text(
                      l10n.reservationScheduleLabel,
                      style: TextStyle(
                          color: MainTheme.contrast(context),
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () => _showDatePicker(context, true),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                              child: Text(
                                _startDateTime != null
                                    ? DateFormat('dd/MM/yyyy HH:mm').format(
                                    _startDateTime!)
                                    : l10n.startDateTimeLabel,
                                style: TextStyle(
                                    color: MainTheme.contrast(context),
                                    fontSize: 16),
                              ),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '-',
                            style: TextStyle(
                              fontSize: 30,
                              color: MainTheme.contrast(context),
                            ),
                          ),
                          const SizedBox(height: 2),
                          GestureDetector(
                            onTap: () => _showDatePicker(context, false),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 20.0),
                              child: Text(
                                _endDateTime != null
                                    ? DateFormat('dd/MM/yyyy HH:mm').format(
                                    _endDateTime!)
                                    : l10n.endDateTimeLabel,
                                style: TextStyle(
                                    color: MainTheme.contrast(context),
                                    fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),

                    // Mostrar el precio a pagar
                    if (_totalPrice > 0)
                      Text(
                        '${l10n.priceToPay}: S/.${_totalPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                            color: MainTheme.contrast(context),
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),

                    const SizedBox(height: 20),

                    if (_totalPrice > 0)
                    GestureDetector(
                      onTap: _pickVoucherImage,
                      // Seleccionar imagen del voucher
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
                            Text(
                              l10n.uploadVoucher,
                              style: const TextStyle(
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
                    const SizedBox(height: 20.0),

                    // Botón de reserva
                    Center(
                      child: ElevatedButton(
                        onPressed: _voucherImage != null && _totalPrice > 0
                            ? () async {
                          if (_startDateTime == null || _endDateTime == null) {
                            await showDialog(
                                context: context,
                                builder: (_) =>
                                CustomDialog(
                                    title: l10n.selectValidDates,
                                    route: "/space-info"));
                          }
                          try {
                            await reservationProvider.createReservation(
                                signInProvider.userId,
                                spaceProvider.spaceSelected!.id,
                                _startDateTime!.toIso8601String(),
                                _endDateTime!.toIso8601String(),
                                _totalPrice,
                                _voucherImage!
                            )
                            ;
                            await showDialog(
                                context: context,
                                builder: (_) =>
                                CustomDialog(
                                    title: l10n.reservationSuccessful,
                                    route: "/search-space"));
                          } on DioException catch (e) {
                            Logger().e("Error while creating reservation: $e");
                            if (e.response!.statusCode == 400) {
                              await showDialog(
                                  context: context,
                                  builder: (_) =>
                                  CustomDialog(
                                      title: l10n.cannotReserveOwnSpace,
                                      route: "/search-space"));
                            } else {
                              await showDialog(
                                  context: context,
                                  builder: (_) =>
                                  CustomDialog(
                                      title: l10n.reservationErrorCheck,
                                      route: "/search-space"));
                            }
                          }
                        }
                            : null,
                        // Solo habilitar si se sube imagen del voucher
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          minimumSize: const Size(350, 50),
                          backgroundColor: Colors.orangeAccent,
                          foregroundColor: Colors.white,
                        ),
                        child: Text(l10n.reserve),
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
                l10n.noSpaceSelected,
                style: TextStyle(
                    color: MainTheme.contrast(context), fontSize: 20.0),
              ),
            ),
          ),
        )
    );
  }
}