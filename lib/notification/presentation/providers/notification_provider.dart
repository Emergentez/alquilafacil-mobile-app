
import 'package:alquilafacil/notification/data/remote/helpers/notification_service_helper.dart';
import 'package:alquilafacil/notification/domain/model/alertNotification.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';

class NotificationProvider extends ChangeNotifier{
  List<AlertNotification> notifications = [];
  final NotificationServiceHelper notificationServiceHelper;
  NotificationProvider(this.notificationServiceHelper);

  Future<void> createNotification(String title, String description, int userId) async {
    final notification = AlertNotification(id:0, title: title, description: description, userId: userId);
    await notificationServiceHelper.createNotification(notification);
    notifyListeners();
  }

  Future<void> fetchNotificationsByUserId(int userId) async {
    notifications = await notificationServiceHelper.getAllNotificationsByUserId(userId);
    notifyListeners();
  }

  Future<void> deleteNotification(int notificationId) async{
    await notificationServiceHelper.deleteNotification(notificationId);
    notifications.removeWhere((notification) => notification.id == notificationId);
    notifyListeners();
  }

}