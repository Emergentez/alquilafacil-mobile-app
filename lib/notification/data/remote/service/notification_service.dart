import '../../../domain/model/alertNotification.dart';

abstract class NotificationService{
  Future<List<AlertNotification>> getAllNotificationsByUserId(int userId);
  Future<void> createNotification(AlertNotification notification);
  Future<void> deleteNotification(int notificationId);
}