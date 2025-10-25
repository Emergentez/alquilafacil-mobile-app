import 'package:alquilafacil/profile/presentation/providers/profile_provider.dart';
import 'package:alquilafacil/public/presentation/widgets/screen_bottom_app_bar.dart';
import 'package:alquilafacil/spaces/presentation/widgets/report_submit_details.dart';
import 'package:alquilafacil/spaces/presentation/providers/space_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../public/ui/providers/theme_provider.dart';
import '../../../public/ui/theme/main_theme.dart';

class CreateReportScreen extends StatelessWidget {
  const CreateReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final spaceProvider = context.watch<SpaceProvider>();
    final profileProvider = context.watch<ProfileProvider>();
    final themeProvider = Provider.of<ThemeProvider>(context);
    final TextEditingController descriptionReportController = TextEditingController();
    final TextEditingController titleReportController = TextEditingController();
    return Scaffold(
      backgroundColor: MainTheme.background(context),
      appBar: AppBar(
        title: const Text('Reportar espacio', style: TextStyle(color: Colors.white)),
        backgroundColor: MainTheme.primary(context),
        leading: IconButton(
          icon:  const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               ReportSubmitDetails(
                 ownerName: profileProvider.usernameExpect,
                 localName: spaceProvider.spaceSelected!.localName,
                 descriptionReportController: descriptionReportController,
                 titleReportController: titleReportController,
                 localId: spaceProvider.spaceSelected!.id,
                 userId: spaceProvider.spaceSelected!.userId!,
               ),
              ],
            ),
          ),
        ),
      bottomNavigationBar: const ScreenBottomAppBar(),
    );
  }
}
