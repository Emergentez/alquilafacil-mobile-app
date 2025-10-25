import 'package:alquilafacil/auth/presentation/providers/SignInProvider.dart';
import 'package:alquilafacil/contact/presentation/widgets/notification_preview.dart';
import 'package:alquilafacil/notification/presentation/providers/notification_provider.dart';
import 'package:alquilafacil/public/presentation/widgets/screen_bottom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../public/ui/theme/main_theme.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    super.initState();
    () async {
      final signInProvider = context.read<SignInProvider>();
      final notificationProvider = context.read<NotificationProvider>();
      await notificationProvider.fetchNotificationsByUserId(signInProvider.userId);
    }();
  }

  @override
  Widget build(BuildContext context) {
    final notificationProvider = context.watch<NotificationProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificaciones'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.popAndPushNamed(context, '/search-space');
          },
        ),
      ),
      body: notificationProvider.notifications.isNotEmpty
          ?
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: notificationProvider.notifications.length,
                    itemBuilder: (context, int index) {
                      return Dismissible(
                        key: Key(notificationProvider.notifications[index].id.toString()),
                        onDismissed: (direction) async{
                          await notificationProvider.deleteNotification(notificationProvider.notifications[index].id);
                        },
                        background: Container(
                          color: MainTheme.primary(context),
                        ),
                        child: NotificationPreview(
                          title: notificationProvider.notifications[index].title,
                          message: notificationProvider.notifications[index].description,
                        ),
                      );
                    },
                  )
          :  Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "No tienes notificaciones",
                    style: TextStyle(color: MainTheme.contrast(context)),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: const ScreenBottomAppBar(),
    );
  }
}
