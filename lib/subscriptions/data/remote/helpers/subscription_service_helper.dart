import 'dart:convert';
import 'dart:io';

import 'package:alquilafacil/subscriptions/data/remote/services/subscription_service.dart';
import 'package:alquilafacil/subscriptions/domain/model/subscription.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

import '../../../../auth/presentation/providers/SignInProvider.dart';
import '../../../../shared/constants/constant.dart';
import '../../../../shared/handlers/concrete_response_message_handler.dart';

class SubscriptionServiceHelper extends SubscriptionService{
  final errorMessageHandler = ConcreteResponseMessageHandler();
  final SignInProvider signInProvider;
  SubscriptionServiceHelper(this.signInProvider);
  @override
  Future<void> createSubscription(Subscription subscription) async {
    final request = Dio();
    final token = signInProvider.token;
    final options = Options(headers: {'Authorization': 'Bearer $token'});
    try {
      final response = await request.post(
        "${Constant.BASE_URL}${Constant.RESOURCE_PATH}subscriptions",
        options: options,
        data: subscription.toJson(),
      );
      if (response.statusCode == HttpStatus.created ||
          response.statusCode == HttpStatus.ok) {
        Logger().i("Subscription created successfully");
      } else {
        throw Exception(errorMessageHandler.reject(response.statusCode!));
      }
    } catch (e) {
      Logger().e("Exception caught: $e");
      throw Exception("Error de conexión. Verifica tu red o intenta más tarde.");
    }
  }
  @override
  Future<List<String>> getAdminBankAccounts() async {
    final dio = Dio();
    final token = signInProvider.token;
    final options = Options(headers: {'Authorization': 'Bearer $token'});
    try {
      final request = await dio.get("${Constant.BASE_URL}${Constant.RESOURCE_PATH}profiles/bank-accounts/1", options: options);
      if (request.statusCode == HttpStatus.ok){
        final json = request.data;
        final List<String> bankAccounts = [json[0], json[1]];
        return bankAccounts;
      }else {
        throw Exception(errorMessageHandler.reject(request.statusCode!));
      }
    } catch (e) {
      Logger().e("Error while fetching bank accounts: $e");
      rethrow;
    }
  }

  Future<String> uploadImage(File image) async {
    const String cloudName = "ddd2yf0ii";
    const String uploadPreset = "ml_default";

    try {
      final uri = Uri.parse("https://api.cloudinary.com/v1_1/$cloudName/upload");
      var request = http.MultipartRequest('POST', uri);
      request.fields['upload_preset'] = uploadPreset;
      request.files.add(await http.MultipartFile.fromPath('file', image.path));
      var response = await request.send();
      if (response.statusCode >= 200 || response.statusCode < 300) {
        var responseData = await http.Response.fromStream(response);
        var jsonData = json.decode(responseData.body);
        return jsonData['secure_url'];
      } else {
        throw Exception("Error al subir la imagen a Cloudinary: ${response.statusCode}, ${response.reasonPhrase}");
      }
    } finally {
      image.delete();
    }
  }

  @override
  Future<String> getSubscriptionStatusByUserId() async {
    final dio = Dio();
    final token = signInProvider.token;
    final options = Options(headers: {'Authorization': 'Bearer $token'});
    try {
      final request = await dio.get("${Constant.BASE_URL}${Constant
          .RESOURCE_PATH}profiles/subscription-status/${signInProvider.userId}",
          options: options);
      if (request.statusCode == HttpStatus.ok) {
        final status = request.data;
        return status;
      } else {
        Logger().e("An error has ocurred, userId found ${signInProvider.userId}");
        throw Exception(errorMessageHandler.reject(request.statusCode!));
      }
    } catch (e) {
      Logger().e("Error while fetching subscription status: $e");
      rethrow;
    }
  }

  @override
  Future<List<Subscription>> getAllSubscriptions() async {
    var client = HttpClient();
    try{
      var url = Uri.parse("${Constant.BASE_URL}${Constant.RESOURCE_PATH}subscriptions");
      var token = signInProvider.token;
      Logger().i("Current token: $token");
      var request = await client.getUrl(url);
      request.headers.set(HttpHeaders.authorizationHeader, "Bearer $token");
      var response = await request.close();
      if (response.statusCode == HttpStatus.ok){
        var responseBody = await response.transform(utf8.decoder).join();
        var json = jsonDecode(responseBody);
        final List<dynamic> subscriptions = json;
        return subscriptions.map((sub) => Subscription.fromJson(sub)).toList();
      } else{
        throw Exception(errorMessageHandler.reject(response.statusCode));
      }
    } finally{
      client.close();
    }
  }

  @override
  Future<void> activeSubscription(int subscriptionId) async {
    final dio = Dio();
    final token = signInProvider.token;
    final options = Options(headers: {'Authorization': 'Bearer $token'});
    try {
      final request = await dio.put("${Constant.BASE_URL}${Constant
          .RESOURCE_PATH}subscriptions/$subscriptionId", options: options);
      if (request.statusCode == HttpStatus.ok) {
        Logger().i("Suscripción $subscriptionId activada exitosamente.");
      } else {
        throw Exception(errorMessageHandler.reject(request.statusCode!));
      }
    } catch (e) {
      Logger().e("Error while creating profile: $e");
      rethrow;
    }
  }
}