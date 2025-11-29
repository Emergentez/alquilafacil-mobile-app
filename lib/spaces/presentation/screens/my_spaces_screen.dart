import 'package:alquilafacil/auth/presentation/providers/SignInProvider.dart';
import 'package:alquilafacil/auth/presentation/screens/login.dart';
import 'package:alquilafacil/spaces/presentation/providers/space_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../public/presentation/widgets/screen_bottom_app_bar.dart';
import '../../../public/ui/theme/main_theme.dart';



class MySpacesScreen extends StatefulWidget {
  const MySpacesScreen({super.key});

  @override
  State<MySpacesScreen> createState() => _MySpacesScreenState();
}

class _MySpacesScreenState extends State<MySpacesScreen> {
  @override
  void initState(){
    super.initState();
    () async {
      final spaceProvider = context.read<SpaceProvider>();
      final signInProvider = context.read<SignInProvider>();
      await spaceProvider.fetchMySpaces(signInProvider.userId);
    }();
  }
  @override
  Widget build(BuildContext context) {
    final spaceProvider = context.watch<SpaceProvider>();
    final l10n = AppLocalizations.of(context)!;
    return  Scaffold(
        backgroundColor: MainTheme.background(context),
        appBar: AppBar(
          backgroundColor: MainTheme.primary(context),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: MainTheme.background(context)),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          title: Text(l10n.mySpaces, style: const TextStyle(color: Colors.white),),
        ),
        body: spaceProvider.currentSpaces.isNotEmpty ?
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: spaceProvider.currentSpaces.length,
                    itemBuilder: (BuildContext context, int index){
                      return Card(
                        color: index % 2 == 0 ? MainTheme.background(context) : MainTheme.secondary(context),
                        elevation: 2.0,
                        child: InkWell(
                          onTap: (){
                            spaceProvider.setSelectedSpace(spaceProvider.currentSpaces[index]);
                            Navigator.pushNamed(
                                context, "/my-space-info"
                            );
                          },
                          child: ListTile(
                              title: Text(
                                spaceProvider.currentSpaces[index].localName,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: index % 2 == 0 ? MainTheme.contrast(context) : MainTheme.background(context),
                                ),
                              ),
                              leading: Image.network(
                                spaceProvider.currentSpaces[index].photoUrls[0],
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("S/. ${spaceProvider.currentSpaces[index].price.toString()}",
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      color: index % 2 == 0 ? MainTheme.contrast(context) : MainTheme.background(context),
                                    )
                                  ),
                                  Text(
                                    spaceProvider.currentSpaces[index].address,
                                    textAlign: TextAlign.end,
                                      style: TextStyle(
                                        color: index % 2 == 0 ? MainTheme.contrast(context) : MainTheme.background(context),
                                      )
                                  )
                                ],
                              ),
                          ),
                        ),
                      );
                    }
                  ),
                ),
              ],
            ) ,
          ),
        ) : Center(
          child: CircularProgressIndicator(
            color: MainTheme.secondary(context),
          ),
        )
    );
  }
}

