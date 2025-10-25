import 'dart:convert';
import 'dart:io';

import 'package:alquilafacil/auth/presentation/providers/SignInProvider.dart';
import 'package:alquilafacil/spaces/data/remote/services/local_categories_service.dart';
import 'package:alquilafacil/spaces/domain/model/local_category.dart';
import 'package:logger/logger.dart';

import '../../../../shared/constants/constant.dart';
import '../../../../shared/handlers/concrete_response_message_handler.dart';

class LocalCategoriesServiceHelper extends LocalCategoriesService{
  final SignInProvider signInProvider;
  var errorMessageHandler = ConcreteResponseMessageHandler();
  var logger = Logger();
  LocalCategoriesServiceHelper(this.signInProvider);
  @override
  Future<List<LocalCategory>> getAllLocalCategories() async {
    var client = HttpClient();
    try {
      var url = Uri.parse("${Constant.BASE_URL}${Constant.RESOURCE_PATH}local-categories");
      var token = signInProvider.token;
      var request = await client.getUrl(url);
      request.headers.set(HttpHeaders.authorizationHeader, "Bearer $token");
      var response = await request.close();

      if (response.statusCode == HttpStatus.ok) {
        var responseBody = await response.transform(utf8.decoder).join();
        var json = jsonDecode(responseBody);
        final List<dynamic> localCategories = json;
        return localCategories.map((localCategory) => LocalCategory.fromJson(localCategory)).toList();
      } else {
        throw Exception(errorMessageHandler.reject(response.statusCode));
      }
    } catch (e) {
      logger.e("Error while trying to fecth local categories");
      return [];
    } finally {
      client.close();
    }
  }

}