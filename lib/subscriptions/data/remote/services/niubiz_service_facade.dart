import 'dart:convert';
import 'package:dio/dio.dart';

class NiubizServiceFacade {
  final String apiUrl = 'https://apisandbox.vnforappstest.com';
  final String username = 'integraciones@niubiz.com.pe';
  final String password = '_7z3@8fF';
  String accessToken = "";

  Future<String> createAccessToken() async {
    const url = 'https://apisandbox.vnforappstest.com/api.security/v1/security';
    final headers = {
      'Authorization': 'Basic ${base64Encode(utf8.encode('$username:$password'))}',
      'Content-Type': 'application/json',
    };

    try {
      final response = await Dio().post(url, options: Options(headers: headers));

      print('Respuesta completa: ${response.data}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data is String) {
          accessToken = response.data;
          print('Access Token obtenido: $accessToken');
          return accessToken;
        } else {
          throw Exception('La respuesta no contiene un token válido.');
        }
      } else {
        throw Exception('Error en la solicitud: ${response.statusCode}, ${response.data}');
      }
    } catch (e) {
      print('Error en createAccessToken: $e');
      rethrow;
    }
  }

  Future<String> createSessionToken(String merchantId, double amount) async {
    final String url = '$apiUrl/api.ecommerce/v2/ecommerce/token/session/$merchantId';

    final body = {
      "channel": "web",
      "amount": amount.toStringAsFixed(2),
      "antifraud": {
        'clientIp': '127.0.0.1',
        'merchantDefineData': {
          'MDD15': 'Valor MDD 15',
          'MDD20': 'Valor MDD 20',
        },
      },
      'dataMap': {
        'cardholderCity': 'Lima',
        'cardholderCountry': 'PE',
        'cardholderAddress': 'Av Jose Pardo 123',
        'cardholderPostalCode': '15000',
        'cardholderState': 'LIM',
        'cardholderPhoneNumber': '987654321',
      },
    };

    try {
      final response = await Dio().post(
        url,
        data: jsonEncode(body),
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
          },
        ),
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Headers: ${response.headers}');
      print('Response Body: ${response.data}');

      if (response.statusCode == 200) {
        if (response.data is Map<String, dynamic>) {
          print('Session Key: ${response.data}');
          return response.data;
        } else {
          throw Exception('El sessionKey no está presente en la respuesta.');
        }
      } else {
        print('Error Response: ${response.data}');
        throw Exception('Error al crear token de sesión: ${response.statusCode}');
      }
    } catch (e) {
      print('Error inesperado: $e');
      rethrow;
    }
  }

  Future<String> getSessionKey(String merchantId, double amount) async {
    try {
      await createAccessToken();
      final sessionKey = await createSessionToken(merchantId, amount);
      return sessionKey;
    } catch (e) {
      print('Error en getSessionKey: $e');
      rethrow;
    }
  }
}
