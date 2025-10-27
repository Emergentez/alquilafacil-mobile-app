import 'dart:async';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:alquilafacil/reservation/domain/model/reservation.dart';
import 'package:alquilafacil/public/ui/theme/main_theme.dart';

class MonitoringScreen extends StatefulWidget {
  const MonitoringScreen({super.key});

  @override
  State<MonitoringScreen> createState() => _MonitoringScreenState();
}

class _MonitoringScreenState extends State<MonitoringScreen> {
  late WebSocketChannel _channel;
  final List<String> _messages = [];
  final ScrollController _scrollController = ScrollController();
  bool _hasError = false;
  bool _isConnected = false;
  late int localId;
  Set<int> _recentlyAddedIndexes = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final reservation = ModalRoute.of(context)!.settings.arguments as Reservation;
    localId = reservation.spaceId;

    final String socketUrl =
        'ws://alquilafacil-app.chilecentral.cloudapp.azure.com:3000/api/v1/web-socket/ws/notifications/$localId';

    _channel = WebSocketChannel.connect(Uri.parse(socketUrl));
    _isConnected = true;

    _channel.stream.listen(
          (data) {
        setState(() {
          _messages.add(data);
          _recentlyAddedIndexes.add(_messages.length - 1);

          // Elimina la animación después de 2 segundos
          Future.delayed(const Duration(seconds: 2), () {
            setState(() {
              _recentlyAddedIndexes.remove(_messages.length - 1);
            });
          });

          // Auto-scroll al final si ya está abajo
          if (_scrollController.hasClients) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent + 80,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          }
        });
      },
      onError: (error) {
        setState(() {
          _hasError = true;
          _messages.add('Error de conexión: $error');
        });
      },
      onDone: () {
        setState(() {
          _isConnected = false;
          _messages.add('Conexión cerrada');
        });
      },
    );
  }

  @override
  void dispose() {
    if (_isConnected) {
      _channel.sink.close(status.goingAway);
    }
    _scrollController.dispose();
    super.dispose();
  }

  IconData _getIconForMessage(String message) {
    if (message.contains("HUMO")) return Icons.warning_amber_rounded;
    if (message.contains("RUIDO")) return Icons.volume_up;
    if (message.contains("CAPACIDAD")) return Icons.people;
    if (message.contains("ZONA RESTRINGIDA")) return Icons.lock;
    return Icons.info_outline;
  }

  Color _getColorForMessage(String message) {
    if (message.contains("HUMO")) return Colors.red.shade100;
    if (message.contains("RUIDO")) return Colors.orange.shade100;
    if (message.contains("CAPACIDAD")) return Colors.blue.shade100;
    if (message.contains("ZONA RESTRINGIDA")) return Colors.purple.shade100;
    return Colors.grey.shade200;
  }

  @override
  Widget build(BuildContext context) {
    final reservation = ModalRoute.of(context)!.settings.arguments as Reservation;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Monitoreo del local', style: TextStyle(color: Colors.white)),
        backgroundColor: MainTheme.primary(context),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: MainTheme.background(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (_hasError)
              Text(
                '❌ Error al conectarse al servidor.',
                style: TextStyle(color: Colors.red),
              ),
            const SizedBox(height: 10),
            Expanded(
              child: _messages.isEmpty
                  ? Center(
                child: Text(
                  _isConnected ? 'Esperando noticias...' : 'Desconectado',
                  style: TextStyle(color: MainTheme.contrast(context)),
                ),
              )
                  : ListView.builder(
                controller: _scrollController,
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  final icon = _getIconForMessage(message);
                  final bgColor = _getColorForMessage(message);

                  final isNew = _recentlyAddedIndexes.contains(index);
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: isNew
                          ? [BoxShadow(color: Colors.black12, blurRadius: 6, spreadRadius: 2)]
                          : [],
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: Icon(icon, color: Colors.black87),
                      title: Text(
                        message,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
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