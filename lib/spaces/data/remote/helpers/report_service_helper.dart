import 'dart:io';

import 'package:alquilafacil/auth/presentation/providers/SignInProvider.dart';
import 'package:alquilafacil/shared/constants/constant.dart';
import 'package:alquilafacil/shared/handlers/concrete_response_message_handler.dart';
import 'package:alquilafacil/spaces/data/remote/services/report_service.dart';
import 'package:alquilafacil/spaces/domain/model/report.dart';
import 'package:dio/dio.dart';

class ReportServiceHelper extends ReportService{
  final SignInProvider signInProvider;
  final errorMessageHandler = ConcreteResponseMessageHandler();
  ReportServiceHelper(this.signInProvider);
  @override
  Future<void> createReport(Report report) async  {
    final request = Dio();
    const url = "${Constant.BASE_URL}${Constant.RESOURCE_PATH}report";
    String token = signInProvider.token;
    report.userId = signInProvider.userId;
    final options = Options( headers:  {"Authorization": "Bearer $token"});
    final response  = await request.post(url, data: report.toJson(), options:options );
    if (response.statusCode != HttpStatus.created){
      throw Exception(errorMessageHandler.reject(response.statusCode!));
    }
  }

  @override
  Future<void> deleteReport(int reportId)async {
    final request = Dio();
    final url = "${Constant.BASE_URL}${Constant.RESOURCE_PATH}report/$reportId";
    String token = signInProvider.token;
    final options = Options( headers:  {"Authorization": "Bearer $token"});
    final response = await request.delete(url, options: options);
    if (response.statusCode != HttpStatus.ok){
      throw Exception(errorMessageHandler.reject(response.statusCode!));
    }
  }

  @override
  Future<List<Report>> getReportsByUserId(int userId) async {
    final request = Dio();
    final url = "${Constant.BASE_URL}${Constant.RESOURCE_PATH}report/get-by-user-id/$userId";
    String token = signInProvider.token;
    final options = Options( headers:  {"Authorization": "Bearer $token"});
    final response = await request.get(url, options: options);
    if (response.statusCode != HttpStatus.ok){
      throw Exception(errorMessageHandler.reject(response.statusCode!));
    }else {
      final reportsResponse = response.data as List;
      final reports = reportsResponse.map((reportData) => Report.fromJson(reportData)).toList();
      return reports;
    }
  }
  
}