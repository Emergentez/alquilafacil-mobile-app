import 'dart:convert';
import 'dart:io';

import 'package:alquilafacil/auth/presentation/providers/SignInProvider.dart';
import 'package:alquilafacil/reservation/data/remote/services/reservation_service.dart';
import 'package:alquilafacil/reservation/domain/model/reservation.dart';
import 'package:alquilafacil/shared/handlers/concrete_response_message_handler.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

import '../../../../shared/constants/constant.dart';

class ReservationServiceHelper extends ReservationService{
  var errorMessageHandler = ConcreteResponseMessageHandler();
  final SignInProvider signInProvider;
  ReservationServiceHelper(this.signInProvider);

  @override
  Future<void> createReservation(int userId, int localId, String startDate, String endDate, double price, String voucherImageUrl) async {
     var request = Dio();
     const url = "${Constant.BASE_URL}${Constant.RESOURCE_PATH}reservation";
     final token = signInProvider.token;
     final options = Options(headers: {'Authorization': 'Bearer $token'});
     var reservation = {
       "startDate": startDate,
       "endDate": endDate,
       "userId": userId,
       "localId": localId,
       "price": double.parse(price.toStringAsFixed(2)),
       "voucherImageUrl": voucherImageUrl
     };
     Logger().i(reservation);
     final response = await request.post(url, data: reservation, options: options);
     Logger().i(response);
     if (response.statusCode! < 200 || response.statusCode! >= 300) {
       throw Exception(errorMessageHandler.reject(response.statusCode!));
     }
  }

  @override
  Future<void> modifyReservation(int reservationId, int userId, int localId, String startDate, String endDate) async {
    var request = Dio();
    var url = "${Constant.BASE_URL}${Constant.RESOURCE_PATH}reservation/$reservationId";
    final token = signInProvider.token;
    final options = Options(headers: {'Authorization': 'Bearer $token'});
    var reservation = {
      "startDate": startDate,
      "endDate": endDate,
      "userId": userId,
      "localId": localId
    };
    final response = await request.put(url, data: reservation, options: options);
    if (response.statusCode! < 200 || response.statusCode! >= 300) {
      throw Exception(errorMessageHandler.reject(response.statusCode!));
    }
  }

  @override
  Future<List<Reservation>> getReservationsByUserId(int userId) async {
    var client = HttpClient();
    try {
      var url = Uri.parse("${Constant.BASE_URL}${Constant.RESOURCE_PATH}reservation/by-user-id/$userId");
      var token = signInProvider.token;
      var request = await client.getUrl(url);
      request.headers.set(HttpHeaders.authorizationHeader, "Bearer $token");
      var response = await request.close();
      if (response.statusCode >= 200 || response.statusCode < 300) {
        var responseBody = await response.transform(utf8.decoder).join();
        final List<dynamic> reservations =jsonDecode(responseBody);
        return reservations.map((reservation) => Reservation.fromJson(reservation)).toList();
      }
      else {
        throw Exception(errorMessageHandler.reject(response.statusCode));
      }
    } finally {
      client.close();
    }
  }

  @override
  Future<List<Reservation>> getOtherUsersReservationsByUserId(int userId) async {
    var client = HttpClient();
    try {
      var url = Uri.parse("${Constant.BASE_URL}${Constant.RESOURCE_PATH}reservation/reservation-user-details/$userId");
      var token = signInProvider.token;
      var request = await client.getUrl(url);
      request.headers.set(HttpHeaders.authorizationHeader, "Bearer $token");
      var response = await request.close();
      if(response.statusCode == HttpStatus.ok){
        var responseBody = await response.transform(utf8.decoder).join();
        final Map<String, dynamic> responseJson = jsonDecode(responseBody);
        Logger().i(responseJson);
        final List<dynamic> reservations = responseJson['reservations'];
        Logger().i(reservations);
        return reservations.map((reservation) => Reservation.fromJsonfromOtherUsers(reservation)).toList();
      }
      else {
        throw Exception(errorMessageHandler.reject(response.statusCode));
      }
    } finally {
      client.close();
    }
  }

  Future <void> deleteReservation(int reservationId) async {
    var request = Dio();
    var url = "${Constant.BASE_URL}${Constant.RESOURCE_PATH}reservation/$reservationId";
    final token = signInProvider.token;
    final options = Options(headers: {'Authorization': 'Bearer $token'});
    final response = await request.delete(url, options: options);
    if (response.statusCode! < 200 || response.statusCode! >= 300) {
      throw Exception(errorMessageHandler.reject(response.statusCode!));
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

}