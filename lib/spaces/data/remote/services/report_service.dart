import '../../../domain/model/report.dart';

abstract class ReportService {
  Future<void> createReport(Report report);
  Future<List<Report>> getReportsByUserId(int userId);
  Future<void> deleteReport(int reportId);
}
