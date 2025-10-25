import 'package:alquilafacil/public/presentation/widgets/screen_bottom_app_bar.dart';
import 'package:alquilafacil/public/ui/theme/main_theme.dart';
import 'package:alquilafacil/spaces/presentation/widgets/card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../public/ui/providers/theme_provider.dart';
import '../providers/space_provider.dart';

class SpacesDetails extends StatefulWidget {
  const SpacesDetails({super.key});
  @override
  State<StatefulWidget> createState() => _SpaceDetailsState();
}

class _SpaceDetailsState extends State<SpacesDetails> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final spaceProvider = context.read<SpaceProvider>();
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

      if (args != null) {
        final district = args['district'];
        if (district != null) {
          spaceProvider.searchSpaceByName(district);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final spaceProvider = context.watch<SpaceProvider>();
    return Scaffold(
     appBar: AppBar(
        backgroundColor: themeProvider.isDarkTheme
            ? MainTheme.primary(context)
            : MainTheme.background(context),
        centerTitle: true, 
        title: Text(
          "Espacios encontrados",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: MainTheme.contrast(context),
            fontSize: 20,
          ),
        ),
      ),
      backgroundColor: MainTheme.background(context),
      bottomNavigationBar: const ScreenBottomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              spaceProvider.currentSpaces.isNotEmpty
                  ? ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return SpaceCard(
                          id: spaceProvider.currentSpaces[index].id,
                          userId: spaceProvider.currentSpaces[index].userId!,
                          address: spaceProvider.currentSpaces[index].address,
                          price: spaceProvider.currentSpaces[index].price.toString(),
                          imageUrl: spaceProvider.currentSpaces[index].photoUrls[0]
                        );
                      },
                      itemCount: spaceProvider.currentSpaces.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: 10);
                      },
                    )
                  : Text(
                      "No existen locales con estos parámetros",
                      style: TextStyle(color: MainTheme.contrast(context)),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
