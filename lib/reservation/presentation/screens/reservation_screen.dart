import 'package:alquilafacil/public/presentation/widgets/screen_bottom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({super.key});

  @override
  _ReservationScreen createState() => _ReservationScreen();
}

class _ReservationScreen extends State<ReservationScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStartTime ? (startTime ?? TimeOfDay.now()) : (endTime ?? TimeOfDay.now()),
    );
    if (picked != null) {
      setState(() {
        if (isStartTime) {
          startTime = picked;
        } else {
          endTime = picked;
        }
      });
    }
  }

  void _validateAndNavigate() {
    if (startTime == null || endTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, selecciona la hora de inicio y fin.'), backgroundColor: Colors.red),
      );
    } else if (endTime!.hour < startTime!.hour ||
        (endTime!.hour == startTime!.hour && endTime!.minute <= startTime!.minute)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('La hora de fin debe ser después de la hora de inicio.'), backgroundColor: Colors.red),
      );
    } else if (_selectedDay == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, selecciona una fecha.'), backgroundColor: Colors.red),
      );
    } else {
      // Navegar a la página de confirmación de la reserva
      // Navigator.pushNamed(context, '/reservation/confirmation');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Calendario de Reservas'),
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Detalles del Espacio',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24.0),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Descripción del espacio aquí...',
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Fecha:',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
                TableCalendar(
                  locale: "es_ES",
                  rowHeight: 40.0,
                  focusedDay: _focusedDay,
                  firstDay: DateTime.utc(2024, 9, 1),
                  lastDay: DateTime.utc(2025, 9, 30),
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Hora:',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => _selectTime(context, true),
                      child: Text(startTime != null ? startTime!.format(context) : "Hora de inicio"),
                    ),
                    ElevatedButton(
                      onPressed: () => _selectTime(context, false),
                      child: Text(endTime != null ? endTime!.format(context) : "Hora de fin"),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                const Text(
                  "Mensaje (opcional):",
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
                const TextField(
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: "Mensaje",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _validateAndNavigate,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      backgroundColor: Colors.orangeAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Text("Reservar", style: TextStyle(fontSize: 20.0)),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: const ScreenBottomAppBar());
  }
}