import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../profile/presentation/providers/profile_provider.dart';
import '../../../public/ui/theme/main_theme.dart';
import '../../../spaces/presentation/providers/space_provider.dart';
import '../../../spaces/presentation/widgets/edit_space_field.dart';

class EditSpaceInfo extends StatefulWidget {
  const EditSpaceInfo({super.key});

  @override
  State<EditSpaceInfo> createState() => _EditSpaceInfoState();
}

class _EditSpaceInfoState extends State<EditSpaceInfo> {

  late TextEditingController localNameController;
  late TextEditingController capacityController;
  late TextEditingController descriptionController;
  late TextEditingController addressController;

  @override
  void initState() {
    super.initState();
    final spaceProvider = context.read<SpaceProvider>();
    localNameController =
        TextEditingController(text: spaceProvider.spaceSelected!.localName);
    capacityController = TextEditingController(
        text: spaceProvider.spaceSelected!.capacity.toString());
    descriptionController = TextEditingController(
        text: spaceProvider.spaceSelected!.descriptionMessage);
    addressController =
        TextEditingController(text: spaceProvider.spaceSelected!.address);

  }

  @override
  void dispose() {
    localNameController.dispose();
    capacityController.dispose();
    descriptionController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final spaceProvider = context.watch<SpaceProvider>();
    final profileProvider = context.watch<ProfileProvider>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        EditSpaceField(
          controller: localNameController,
          onValueChanged: (value) =>
              spaceProvider.setLocalName(value),
          hintText: 'Nombre del local',
        ),
        EditSpaceField(
          controller: addressController,
          onValueChanged: (value) =>
              spaceProvider.setAddress(value),
          hintText: 'Dirección (Calle, Distrito, Ciudad, País)',
        ),
        EditSpaceField(
          controller: capacityController,
          onValueChanged: (value) {
            try {
              final intValue = int.tryParse(value);
              spaceProvider.setCapacity(intValue!);
            } catch (_) {
              spaceProvider.setCapacity(spaceProvider.spaceSelected!.capacity);
            }
          },
          hintText: 'Aforo del local',
        ),
        const SizedBox(height: 20),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Propietario: ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: MainTheme.contrast(context),
                  fontSize: 18.0,
                ),
              ),
              TextSpan(
                text: profileProvider.usernameExpect,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: MainTheme.contrast(context),
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.start,
        ),
        const SizedBox(height: 20),
        Text(
          "Descripción:",
          style: TextStyle(
              color: MainTheme.contrast(context),
              fontWeight: FontWeight.bold,
              fontSize: 17.0),
        ),
        EditSpaceField(
          controller: descriptionController,
          onValueChanged: (value) =>
              spaceProvider.setDescriptionMessage(value),
          hintText: 'Descripción del local',
        ),
      ],
    );
  }
}
