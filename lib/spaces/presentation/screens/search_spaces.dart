import 'package:alquilafacil/public/presentation/widgets/screen_bottom_app_bar.dart';
import 'package:alquilafacil/public/ui/theme/main_theme.dart';
import 'package:alquilafacil/spaces/presentation/providers/space_provider.dart';
import 'package:alquilafacil/spaces/presentation/widgets/card.dart';
import 'package:alquilafacil/spaces/presentation/widgets/search_space_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../public/ui/providers/theme_provider.dart';

class SearchSpaces extends StatefulWidget {
  const SearchSpaces({super.key});
  @override
  State<StatefulWidget> createState() => _SearchSpaces();
}

class _SearchSpaces extends State<SearchSpaces> {
  @override
  void initState() {
    super.initState();
    final spaceProvider = context.read<SpaceProvider>();
    () async {
      await spaceProvider.getAllSpaces();
    }();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final spaceProvider = context.watch<SpaceProvider>();
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      bottomNavigationBar: const ScreenBottomAppBar(),
      backgroundColor: MainTheme.background(context),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 60.0, left: 10.0, right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/filter-spaces');
                  },
                  child: Container(
                    width: 250,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: themeProvider.isDarkTheme
                          ? MainTheme.primary(context)
                          : Colors.black12,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.search_outlined, color: MainTheme.contrast(context)),
                        const SizedBox(width: 10),
                        Text(
                          l10n.searchSpaces,
                          style: TextStyle(color: MainTheme.contrast(context), fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                Container(
                  decoration: BoxDecoration(
                      color: themeProvider.isDarkTheme
                          ? MainTheme.primary(context)
                          : Colors.black12,
                      borderRadius: BorderRadius.circular(25.0)),
                  child: IconButton(
                      onPressed: () =>
                          {Navigator.pushNamed(context, "/filter-screen")},
                      icon: const Icon(
                        Icons.filter_alt,
                      )),
                )
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          Expanded(
            child: ListView.separated(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              itemBuilder: (BuildContext context, int index) {
                return SpaceCard(
                  address: spaceProvider.spaces[index].address,
                  price: spaceProvider.spaces[index].price.toString(),
                  imageUrl: spaceProvider.spaces[index].photoUrls[0],
                  id: spaceProvider.spaces[index].id,
                  userId: spaceProvider.spaces[index].userId!,
                );
              },
              itemCount: spaceProvider.spaces.length,
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 10);
              },
            ),
          ),
        ],
      ),
    );
  }
}
