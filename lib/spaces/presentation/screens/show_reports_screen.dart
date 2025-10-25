import 'package:alquilafacil/auth/presentation/providers/SignInProvider.dart';
import 'package:alquilafacil/contact/presentation/widgets/notification_preview.dart';
import 'package:alquilafacil/notification/presentation/providers/notification_provider.dart';
import 'package:alquilafacil/public/presentation/widgets/screen_bottom_app_bar.dart';
import 'package:alquilafacil/spaces/presentation/providers/report_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../public/ui/theme/main_theme.dart';

class ShowReportsScreen extends StatefulWidget {
  const ShowReportsScreen({super.key});

  @override
  State<ShowReportsScreen> createState() => _ShowReportsScreenState();
}

class _ShowReportsScreenState extends State<ShowReportsScreen> {
  @override
  void initState() {
    super.initState();
    () async {
      final signInProvider = context.read<SignInProvider>();
      final reportProvider = context.read<ReportProvider>();
      await reportProvider.fetchAllCurrentReportsByUserId(signInProvider.userId);
    }();
  }

  @override
  Widget build(BuildContext context) {
    final reportProvider = context.watch<ReportProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reportes'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.popAndPushNamed(context, '/search-space');
          },
        ),
      ),
      body: reportProvider.currentReports.isNotEmpty
          ?  ListView.builder(
          shrinkWrap: true,
          itemCount: reportProvider.currentReports.length,
          itemBuilder: (context, int index) {
            return Dismissible(
              key: Key(reportProvider.currentReports[index].id.toString()),
              background: Container(
                color: MainTheme.primary(context),
              ),
              onDismissed: (direction) async {
                await reportProvider.deleteReport(reportProvider.currentReports[index].id);
              },
              child: NotificationPreview(
                title: reportProvider.currentReports[index].title,
                message: reportProvider.currentReports[index].description,
              ),
            );
          },
        )
          :  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "No tienes reportes",
              style: TextStyle(color: MainTheme.contrast(context)),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const ScreenBottomAppBar(),
    );
  }
}
