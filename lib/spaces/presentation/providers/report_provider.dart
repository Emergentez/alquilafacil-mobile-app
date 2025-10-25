import 'package:alquilafacil/spaces/data/remote/helpers/report_service_helper.dart';
import 'package:flutter/material.dart';

import '../../domain/model/report.dart';

class ReportProvider extends ChangeNotifier{
  List<Report> currentReports = [];
  final ReportServiceHelper reportServiceHelper;

  ReportProvider(this.reportServiceHelper);
  Future<void> fetchAllCurrentReportsByUserId(int userId) async{
    currentReports = await reportServiceHelper.getReportsByUserId(userId);
    notifyListeners();
  }

  Future<void> createReport(Report report) async {
    await reportServiceHelper.createReport(report);
    notifyListeners();
  }

  Future<void> deleteReport(int reportId) async {
    await reportServiceHelper.deleteReport(reportId);
    currentReports.removeWhere((report) => report.id == reportId);
    notifyListeners();
  }
}