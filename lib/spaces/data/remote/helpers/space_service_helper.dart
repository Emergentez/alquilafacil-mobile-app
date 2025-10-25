import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import 'package:alquilafacil/auth/presentation/providers/SignInProvider.dart';
import 'package:alquilafacil/shared/handlers/concrete_response_message_handler.dart';
import 'package:alquilafacil/spaces/data/remote/services/spaces_service.dart';
import 'package:logger/logger.dart';

import '../../../../shared/constants/constant.dart';
import '../../../domain/model/space.dart';

class SpaceServiceHelper extends SpaceService{
  final SignInProvider signInProvider;
  var errorMessageHandler = ConcreteResponseMessageHandler();
  var logger = Logger();
  SpaceServiceHelper(this.signInProvider);

  @override
  Future<String> createSpace(Space space) async {
    var client = HttpClient();
    try {
      var url = Uri.parse("${Constant.BASE_URL}${Constant.RESOURCE_PATH}locals");
      var token = signInProvider.token;
      space.userId = signInProvider.userId;
      var request = await client.postUrl(url);
      request.headers.set(HttpHeaders.contentTypeHeader, "application/json");
      request.headers.set(HttpHeaders.authorizationHeader, "Bearer $token");

      var requestBody = jsonEncode(space.toJson());
      request.add(utf8.encode(requestBody));
      var response = await request.close();

      if (response.statusCode == HttpStatus.created) {
        return "Espacio creado exitosamente";
      } else {
        throw Exception(errorMessageHandler.reject(response.statusCode));
      }
    } finally {
      client.close();
    }
  }

  @override
  Future<List<Space>> getAllSpaces() async {
    var client = HttpClient();
    try{
      var url = Uri.parse("${Constant.BASE_URL}${Constant.RESOURCE_PATH}locals");
      var token = signInProvider.token;
      logger.i("Current token: $token");
      var request = await client.getUrl(url);
      request.headers.set(HttpHeaders.authorizationHeader, "Bearer $token");
      var response = await request.close();
      if (response.statusCode == HttpStatus.ok){
        var responseBody = await response.transform(utf8.decoder).join();
        var json = jsonDecode(responseBody);
        final List<dynamic> spaces = json;
        return spaces.map((space) => Space.fromJson(space)).toList();
      } else{
        throw Exception(errorMessageHandler.reject(response.statusCode));
      }
    } finally{
      client.close();
    }
  }

  @override
  Future<Space> getSpaceById(int id) async {
    var client = HttpClient();
    try{
      var url = Uri.parse('${Constant.BASE_URL}${Constant.RESOURCE_PATH}locals/$id');
      var token = signInProvider.token;
      var request = await client.getUrl(url);
      request.headers.set(HttpHeaders.authorizationHeader, "Bearer $token");
      var response = await request.close();
      if(response.statusCode == HttpStatus.ok){
        var responseBody = await response.transform(utf8.decoder).join();
        final json = jsonDecode(responseBody);
        return Space.fromJson(json);
      } else{
        throw Exception(errorMessageHandler.reject(response.statusCode));
      }

    } finally{
      client.close();
    }
  }

  @override
  Future<Space> updateSpace(int spaceId, Map<String, dynamic> spaceToUpdate ) async {
    final dio = Dio();
    var token = signInProvider.token;
    var options = Options(headers: {'Authorization': 'Bearer $token'});
    try{
      final request = await dio.put(
          "${Constant.BASE_URL}${Constant.RESOURCE_PATH}locals/$spaceId",
          data: spaceToUpdate, options: options
      );
      if (request.statusCode == HttpStatus.ok) {
        final json = request.data;
        return Space.fromJson(json);
      } else {
        throw Exception(errorMessageHandler.reject(request.statusCode!));
      }
    } catch(e){
      Logger().e("Error while update space $e");
      rethrow;
    }

  }

  @override
  Future<List<Space>> getAllSpacesByCategoryIdAndCapacityRange(int categoryId, int minRange, int maxRange) async {
    var client = HttpClient();
    try {
      var url = Uri.parse("${Constant.BASE_URL}${Constant.RESOURCE_PATH}locals/search-by-category-id-capacity-range/$categoryId/$minRange/$maxRange");
      var token = signInProvider.token;
      logger.i("Current token: $token");
      var request = await client.getUrl(url);
      request.headers.set(HttpHeaders.authorizationHeader, "Bearer $token");
      var response = await request.close();
      if(response.statusCode == HttpStatus.ok){
        var responseBody = await response.transform(utf8.decoder).join();
        final List<dynamic> locals = jsonDecode(responseBody);
        return locals.map((local) => Space.fromJson(local)).toList();
      }
      else {
        throw Exception(errorMessageHandler.reject(response.statusCode));
      }
    } finally {
      client.close();
    }

  }

  @override
  Future<HashSet<String>> getAllDistricts() async {
    var client = HttpClient();
    try{
      var url = Uri.parse("${Constant.BASE_URL}${Constant.RESOURCE_PATH}locals/get-all-districts");
      var token = signInProvider.token;
      logger.i("Current token: $token");
      var request = await client.getUrl(url);
      request.headers.set(HttpHeaders.authorizationHeader, "Bearer $token");
      var response = await request.close();
      if (response.statusCode == HttpStatus.ok){
        var responseBody = await response.transform(utf8.decoder).join();
        final List<dynamic> districts = jsonDecode(responseBody);
        final HashSet<String> districtsResponse = HashSet<String>.from(districts.map((district) => district.toString()));
        return districtsResponse;
      } else {
        throw Exception(errorMessageHandler.reject(response.statusCode));
      }
    } finally{
      client.close();
    }
  }

  @override
  Future<List<Space>> getSpacesByUserId(int userId) async {
    final dio = Dio();
    var token = signInProvider.token;
    var options = Options(headers: {'Authorization': 'Bearer $token'});

    final request = await dio.get(
      "${Constant.BASE_URL}${Constant.RESOURCE_PATH}locals/get-user-locals/$userId",
      options: options,
    );

    if (request.statusCode == HttpStatus.ok) {
      final List<dynamic> json = request.data;
      return json.map((space) => Space.fromJson(space)).toList().cast<Space>();
    } else {
      throw Exception(errorMessageHandler.reject(request.statusCode!));
    }
  }

  List<int> getFilterRanges(List<String> ranges) {
    List<int> parsedRanges = [];

    for (int index = 0; index < ranges.length; index++) {
      List<String> currentRanges = ranges[index].split("-");
      int min = int.parse(currentRanges[0]);
      int max = int.parse(currentRanges[1]);
      parsedRanges.add(min);
      parsedRanges.add(max);
    }
    return parsedRanges;
  }

  @override
  Future<String> uploadImage(File image) async {
    const String cloudName = "ddd2yf0ii";
    const String uploadPreset = "ml_default";

    try {
      final uri = Uri.parse(
          "https://api.cloudinary.com/v1_1/$cloudName/upload");
      var request = http.MultipartRequest('POST', uri);
      request.fields['upload_preset'] = uploadPreset;
      request.files.add(await http.MultipartFile.fromPath('file', image.path));
      var response = await request.send();
      if (response.statusCode == 200) {
        var responseData = await http.Response.fromStream(response);
        var jsonData = json.decode(responseData.body);
        return jsonData['secure_url'];
      } else {
        throw Exception("Error al subir la imagen a Cloudinary: ${response
            .statusCode}, ${response.reasonPhrase}");
      }
    } finally {
      image.delete();
    }
  }

  Future<List<String>> uploadImages(List<File> images) async {
    try {
      return await Future.wait(images.map((file) => uploadImage(file)));
    } catch (e) {
      rethrow;
    }
  }
}