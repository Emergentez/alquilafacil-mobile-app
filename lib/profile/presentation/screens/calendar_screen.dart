import 'package:alquilafacil/public/presentation/widgets/default_calendar_day.dart';
import 'package:alquilafacil/public/presentation/widgets/screen_bottom_app_bar.dart';
import 'package:alquilafacil/public/ui/theme/main_theme.dart';
import 'package:alquilafacil/reservation/presentation/providers/reservation_provider.dart';
import 'package:alquilafacil/spaces/presentation/providers/space_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../auth/presentation/providers/SignInProvider.dart';
import '../../../reservation/domain/model/reservation.dart';
import '../widgets/event_type_indicator.dart';
import '../widgets/highlighted_calendar_day.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final DateTime _focusedDay = DateTime.now();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    final signInProvider = context.read<SignInProvider>();
    final reservationProvider = context.read<ReservationProvider>();
    _loadReservations(signInProvider.userId, reservationProvider);
  }

  Future<void> _loadReservations(int userId, ReservationProvider reservationProvider) async {
    await reservationProvider.getReservationsByUserId(userId);
    await reservationProvider.getOtherUsersReservationsByUserId(userId);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final reservationProvider = context.watch<ReservationProvider>();
    final spaceProvider = context.watch<SpaceProvider>();
    final l10n = AppLocalizations.of(context)!;

    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.calendar)),
        body: Center(child: CircularProgressIndicator(color: MainTheme.secondary(context))),
        bottomNavigationBar: const ScreenBottomAppBar(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.calendar),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.popAndPushNamed(context, '/search-space');
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              l10n.tapDateForDetails,
              style: TextStyle(color: MainTheme.contrast(context), fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                child: Column(
                  children: [
                    TableCalendar(
                      locale: "es_ES",
                      rowHeight: 40.0,
                      calendarStyle: const CalendarStyle(
                        isTodayHighlighted: false,
                        defaultTextStyle: TextStyle(color: Colors.grey),
                        tableBorder: TableBorder(
                          top: BorderSide(color: Colors.grey),
                          bottom: BorderSide(color: Colors.grey),
                          left: BorderSide(color: Colors.grey),
                          right: BorderSide(color: Colors.grey),
                        ),
                      ),
                      headerStyle: HeaderStyle(
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(color: Colors.grey),
                            left: BorderSide(color: Colors.grey),
                            right: BorderSide(color: Colors.grey),
                          ),
                        ),
                        titleTextStyle: TextStyle(color: MainTheme.contrast(context)),
                        formatButtonVisible: false,
                        titleCentered: true,
                      ),
                      daysOfWeekHeight: 40.0,
                      focusedDay: _focusedDay,
                      firstDay: DateTime.utc(2024, 09, 01),
                      lastDay: DateTime.utc(2026, 12, 31),
                      calendarBuilders: CalendarBuilders(
                        defaultBuilder: (context, day, focusedDay) {
                          return DefaultCalendarDay(day: day);
                        },
                        outsideBuilder: (context, day, focusedDay) {
                          return DefaultCalendarDay(day: day, isOutside: true);
                        },
                        dowBuilder: (context, day) {
                          final text = DateFormat.E("es_ES").format(day);
                          final capitalizedText = text.replaceFirst(text[0], text[0].toUpperCase());
                          return Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                              shape: BoxShape.rectangle,
                            ),
                            child: Center(
                              child: Text(
                                capitalizedText,
                                style: TextStyle(
                                  color: MainTheme.contrast(context),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          );
                        },
                        markerBuilder: (context, day, events) {
                          final List<Reservation> matchingReservations = reservationProvider.reservations.where(
                                (reservation) => reservation.startDate.year == day.year &&
                                reservation.startDate.month == day.month &&
                                reservation.startDate.day == day.day,
                          ).toList();

                          final List<Reservation> matchingOtherUsersReservations = reservationProvider.reservationsFromOtherUsers.where(
                                (reservation) => reservation.startDate.year == day.year &&
                                reservation.startDate.month == day.month &&
                                reservation.startDate.day == day.day,
                          ).toList();

                          if (matchingReservations.isNotEmpty) {
                            final reservation = matchingReservations.first;
                            return HighlightedCalendarDay(
                              day: day,
                              color: Colors.red,
                              onTap: () async {
                                await spaceProvider.fetchSpaceById(reservation.spaceId);
                                Navigator.pushNamed(
                                  context,
                                  '/reservation-details',
                                  arguments: reservation,
                                );
                              },
                            );
                          }

                          if (matchingOtherUsersReservations.isNotEmpty) {
                            final reservation = matchingOtherUsersReservations.first;
                            return HighlightedCalendarDay(
                              day: day,
                              color: reservation.isSubscribed ?? false ? Colors.amberAccent : Colors.blue,
                              onTap: () async {
                                await spaceProvider.fetchSpaceById(reservation.spaceId);
                                Navigator.pushNamed(
                                  context,
                                  '/modify-reservation',
                                  arguments: reservation,
                                );
                              },
                            );
                          }

                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          EventTypeIndicator(color: Colors.red, text: l10n.reservationEvent),
                          const SizedBox(height: 16.0),
                          EventTypeIndicator(color: Colors.blue, text: l10n.spaceReservation),
                          const SizedBox(height: 16.0),
                          EventTypeIndicator(color: Colors.amberAccent, text: l10n.premiumSpaceReservation),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const ScreenBottomAppBar(),
    );
  }
}
