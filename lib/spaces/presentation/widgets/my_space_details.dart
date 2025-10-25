import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../profile/presentation/providers/profile_provider.dart';
import '../../../public/ui/theme/main_theme.dart';
import '../../../reservation/presentation/widgets/edit_space_info.dart';
import '../../../reservation/presentation/widgets/space_info_details.dart';
import '../providers/space_provider.dart';
import 'edit_space_field.dart';
import 'my_space_details_actions.dart';

class MySpaceDetails extends StatefulWidget {
  const MySpaceDetails({super.key});

  @override
  State<MySpaceDetails> createState() => _MySpaceDetailsState();
}

class _MySpaceDetailsState extends State<MySpaceDetails> {
  late TextEditingController _priceController;
  late TextEditingController _featuresController;

  @override
  void initState() {
    super.initState();
    final spaceProvider = context.read<SpaceProvider>();

    _priceController = TextEditingController(
      text: spaceProvider.spaceSelected!.price.toString(),
    );
    _featuresController = TextEditingController(
      text: spaceProvider.spaceSelected!.features,
    );

    () async {
      final profileProvider = context.read<ProfileProvider>();
      await profileProvider
          .fetchUsernameExpect(spaceProvider.spaceSelected!.userId!);
    }();
  }

  @override
  void dispose() {
    _priceController.dispose();
    _featuresController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final spaceProvider = context.watch<SpaceProvider>();
    final profileProvider = context.watch<ProfileProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MainTheme.primary(context),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: MainTheme.background(context)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Mis espacios",
            style: TextStyle(color: MainTheme.background(context))),
      ),
      body: spaceProvider.spaceSelected != null
          ? SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              spaceProvider.spaceSelected!.photoUrls[0],
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            const SizedBox(height: 15),
            Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  !spaceProvider.isEditMode
                      ? SpaceInfoDetails(
                    localName:
                    spaceProvider.spaceSelected!.localName,
                    capacity: spaceProvider.spaceSelected!.capacity,
                    username: profileProvider.usernameExpect,
                    description: spaceProvider
                        .spaceSelected!.descriptionMessage,
                    address:
                    spaceProvider.spaceSelected!.address,
                    isEditMode: spaceProvider.isEditMode,
                    features:
                    spaceProvider.spaceSelected!.features,
                  )
                      : const EditSpaceInfo(),
                  const SizedBox(height: 15),
                  spaceProvider.isEditMode
                      ? EditSpaceField(
                    controller: _priceController,
                    onValueChanged: (newPriceNight) {
                      int? currentPriceNight =
                      int.tryParse(newPriceNight);
                      spaceProvider
                          .setCurrentPrice(currentPriceNight!);
                    },
                    hintText: 'Precio',
                  )
                      : Text(
                    "Precio por hora: S/.${spaceProvider.spaceSelected!.price}",
                    style: TextStyle(
                        color: MainTheme.contrast(context)),
                  ),
                  const SizedBox(height: 15),
                  spaceProvider.isEditMode
                      ? EditSpaceField(
                    controller: _featuresController,
                    onValueChanged: (newFeatures) {
                      spaceProvider
                          .setFeatures(newFeatures.toString());
                    },
                    hintText: 'Servicios adicionales',
                  )
                      : Text(
                    "Servicios adicionales: ${spaceProvider.spaceSelected!.features}",
                    style: TextStyle(
                        color: MainTheme.contrast(context)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            const MySpaceDetailsActions(),
          ],
        ),
      )
          : Center(
        child: CircularProgressIndicator(
          color: MainTheme.secondary(context),
        ),
      ),
    );
  }
}
