import 'dart:io';

import 'package:alquilafacil/auth/presentation/providers/SignInProvider.dart';
import 'package:alquilafacil/notification/data/remote/service/notification_service.dart';
import 'package:alquilafacil/notification/domain/model/alertNotification.dart';
import 'package:alquilafacil/shared/handlers/concrete_response_message_handler.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../../../../shared/constants/constant.dart';

class NotificationServiceHelper extends NotificationService{
  final ConcreteResponseMessageHandler errorMessageHandler = ConcreteResponseMessageHandler();
  final SignInProvider signInProvider;
  NotificationServiceHelper(this.signInProvider);
  @override
  Future<void> createNotification(AlertNotification notification) async {
    final Dio request = Dio();
    const url = "${Constant.BASE_URL}${Constant.RESOURCE_PATH}notification";
    final token = signInProvider.token;
    final options = Options(headers: {'Authorization': 'Bearer $token'});
    final Map<String, dynamic> json = notification.toJson();
    final response = await request.post(url, data: json, options: options);
    if(response.statusCode != HttpStatus.ok){
      throw Exception(errorMessageHandler.reject(response.statusCode!));
    }

  }

  @override
  Future<List<AlertNotification>> getAllNotificationsByUserId(int userId) async {
    final Dio request = Dio();
    final url = "${Constant.BASE_URL}${Constant.RESOURCE_PATH}notification/$userId";
    final token = signInProvider.token;
    final options = Options(headers: {'Authorization': 'Bearer $token'});

    final response = await request.get(url, options: options);

    if (response.statusCode != HttpStatus.ok) {
      throw Exception(errorMessageHandler.reject(response.statusCode!));
    }
    final notifications = (response.data as List)
        .map((json) => AlertNotification.fromJson(json))
        .toList();

    Logger().d(response.data);
    return notifications;
  }

  @override
  Future<void> deleteNotification(int notificationId)async {
    final request = Dio();
    final url = "${Constant.BASE_URL}${Constant.RESOURCE_PATH}notification/$notificationId";
    String token = signInProvider.token;
    final options = Options( headers:  {"Authorization": "Bearer $token"});
    final response = await request.delete(url, options: options);
    if (response.statusCode != HttpStatus.ok){
      throw Exception(errorMessageHandler.reject(response.statusCode!));
    }
  }


}
