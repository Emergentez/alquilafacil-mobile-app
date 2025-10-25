import 'package:alquilafacil/public/presentation/widgets/screen_bottom_app_bar.dart';
import 'package:alquilafacil/spaces/presentation/providers/space_provider.dart';
import 'package:alquilafacil/spaces/presentation/widgets/search_space_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../public/ui/providers/theme_provider.dart';
import '../../../public/ui/theme/main_theme.dart';

class FilterSpacesDistrict extends StatefulWidget {
  const FilterSpacesDistrict({super.key});


  @override
  State<StatefulWidget> createState() => _FilterSpacesDistrict();
}

class _FilterSpacesDistrict extends State<FilterSpacesDistrict> {

  @override
  void initState(){
    super.initState();
    final spaceProvider = context.read<SpaceProvider>();
    () async {
      await spaceProvider.getAllDistricts();
    }();
  }
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final spaceProvider = context.watch<SpaceProvider>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeProvider.isDarkTheme ? MainTheme.primary(context) : MainTheme.background(context),
        title: Text(
              "Realizar búsqueda",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: MainTheme.contrast(context),
              ),
        ),
      ),
      bottomNavigationBar: const ScreenBottomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SearchSpaceButton(
                suffixIcon: Icons.close,
              ),
              const SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index){
                  return ListTile(
                      title: Row(
                      children: [
                        Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: MainTheme.primary(context),
                          ),
                          child: IconButton(
                            icon: Icon(Icons.location_on_sharp, color: Colors.white),
                            color: MainTheme.background(context), onPressed: () {
                              Navigator.pushNamed(
                                  context,
                                  "/spaces-details",
                                arguments: {
                                    "district":  spaceProvider.expectDistricts[index].split(",")[0]
                                }
                              );
                          },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            spaceProvider.expectDistricts[index],
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),

                  );
                },
                itemCount: spaceProvider.expectDistricts.length,
              )
            ],
          ) ,
        ),
      ),
    );
  }
}
