import 'package:alquilafacil/auth/presentation/screens/login.dart';
import 'package:alquilafacil/spaces/presentation/providers/space_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../public/ui/theme/main_theme.dart';

class AdditionalDetailsScreen extends StatelessWidget {
  const AdditionalDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final spaceProvider = context.watch<SpaceProvider>();
    final features = spaceProvider.spaceSelected!.features.split(" ");
    return Scaffold(
      backgroundColor: MainTheme.background(context),
      appBar: AppBar(
        backgroundColor: MainTheme.primary(context),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
            "Detalles adicionales del espacio",
          style: TextStyle(
            color: MainTheme.background(context)
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              spaceProvider.spaceSelected!.photoUrls[0],
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Descripción:",
                    style: TextStyle(
                        color: MainTheme.contrast(context),
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0),
                  ),
                  Text(
                    spaceProvider.spaceSelected!.descriptionMessage,
                    style: TextStyle(color: MainTheme.contrast(context), fontSize: 17.0),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Características del espacio:",
                    style: TextStyle(
                        color: MainTheme.contrast(context),
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0),
                  ),
                  ListView.builder(
                      itemCount: features.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index){
                        return Text(
                          "• ${features[index]}",
                          style: TextStyle(color: MainTheme.contrast(context), fontSize: 17.0),
                        );
                      }
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
