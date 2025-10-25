import 'dart:convert';
import 'dart:io';

import 'package:alquilafacil/auth/data/remote/helpers/auth_service_helper.dart';
import 'package:alquilafacil/auth/presentation/providers/SignInProvider.dart';
import 'package:alquilafacil/profile/data/remote/service/user_service.dart';
import 'package:alquilafacil/profile/domain/model/profile.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../../../../shared/constants/constant.dart';
import '../../../../shared/handlers/concrete_response_message_handler.dart';

class UserServiceHelper extends UserService{
  var errorMessageHandler = ConcreteResponseMessageHandler();
  final SignInProvider signInProvider;
  UserServiceHelper(this.signInProvider);
  @override
  Future<String> getUsernameByUserId(int userId) async {
    var client = HttpClient();
    try{
      var url = Uri.parse(Constant.getEndpoint("users/", "get-username/$userId"));
      var request = await client.getUrl(url);
      var token = signInProvider.token;
      request.headers.set(HttpHeaders.authorizationHeader, "Bearer $token");
      var response = await request.close();
      if (response.statusCode == HttpStatus.ok){
        var responseBody = await response.transform(utf8.decoder).join();
        var json = jsonDecode(responseBody);
        final String username = json;
        Logger().i("Username caught: $username");
        return username;
      } else {
        Logger().e("An error has ocurred, userId found $userId");
        throw Exception(errorMessageHandler.reject(response.statusCode));
      }
    } finally{
      client.close();
    }
  }

  @override
  Future<Profile> getProfileByUserId(int userId)async {
    final dio = Dio();
    final token = signInProvider.token;
    final options = Options(headers: {'Authorization': 'Bearer $token'});
    try {
      final request = await dio.get("${Constant.BASE_URL}${Constant.RESOURCE_PATH}profiles/user/$userId", options: options);
      final bankAccounts = await dio.get("${Constant.BASE_URL}${Constant.RESOURCE_PATH}profiles/bank-accounts/$userId", options: options);
    if (request.statusCode == HttpStatus.ok && bankAccounts.statusCode == HttpStatus.ok){
      final json = request.data;
      var profile = Profile.fromJson(json);
      profile.bankAccount = bankAccounts.data[0];
      profile.interbankAccount = bankAccounts.data[1];
      Logger().i("Profile caught: ${profile}");
      return profile;
    }else {
      throw Exception(errorMessageHandler.reject(request.statusCode!));
    }
  } catch (e) {
      Logger().e("Error while creating profile: $e");
      rethrow;
    }
  }

  @override
  Future<List<String>> getBankAccountsByUserId(int userId) async {
    final dio = Dio();
    final token = signInProvider.token;
    final options = Options(headers: {'Authorization': 'Bearer $token'});
    try {
      final request = await dio.get("${Constant.BASE_URL}${Constant.RESOURCE_PATH}profiles/bank-accounts/$userId", options: options);
      if (request.statusCode == HttpStatus.ok){
        final json = request.data;
        final List<String> bankAccounts = [json[0], json[1]];
        return bankAccounts;
      }else {
        throw Exception(errorMessageHandler.reject(request.statusCode!));
      }
    } catch (e) {
      Logger().e("Error while creating profile: $e");
      rethrow;
    }
  }

  @override
  Future<Profile> updateProfile(int id, Map<String, dynamic> profileToUpdate) async {
    final dio = Dio();
    final token = signInProvider.token;
    final options = Options(headers: {'Authorization': 'Bearer $token'});
    try{
      final request = await dio.put("${Constant.BASE_URL}${Constant.RESOURCE_PATH}profiles/$id", data: profileToUpdate, options: options);
      if (request.statusCode! >= 200 && request.statusCode! < 300){
        final json = request.data;
        final profile = Profile.fromJson(json);
        return profile;
      }else {
        throw Exception(errorMessageHandler.reject(request.statusCode!));
      }
    } catch (e){
      Logger().e("Error while creating profile: $e");
      rethrow;
    }
  }


}