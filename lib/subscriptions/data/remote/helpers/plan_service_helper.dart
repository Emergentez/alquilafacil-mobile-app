import 'dart:io';

import 'package:alquilafacil/auth/presentation/providers/SignInProvider.dart';
import 'package:alquilafacil/shared/handlers/concrete_response_message_handler.dart';
import 'package:alquilafacil/subscriptions/data/remote/services/plan_service.dart';
import 'package:dio/dio.dart';

import '../../../../shared/constants/constant.dart';
import '../../../domain/model/plan.dart';

class PlanServiceHelper extends PlanService{
  final errorMessageHandler = ConcreteResponseMessageHandler();
  final SignInProvider signInProvider;
  PlanServiceHelper(this.signInProvider);
  @override
  Future<List<Plan>> getPlans() async {
    final request = Dio();
    final token = signInProvider.token;
    final options = Options(headers: {'Authorization': 'Bearer $token'});
    final response = await request.get("${Constant.BASE_URL}${Constant.RESOURCE_PATH}plan", options: options);

    if (response.statusCode == HttpStatus.ok) {
      final plans = response.data as List;
      return plans.map((plan) => Plan.fromJson(plan)).toList().cast<Plan>();
    } else {
      throw Exception(errorMessageHandler.reject(response.statusCode!));
    }
  }

}
