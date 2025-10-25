import 'package:alquilafacil/public/presentation/widgets/custom_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../public/ui/theme/main_theme.dart';
import '../providers/profile_provider.dart';

class EditProfileActions extends StatelessWidget {
  const EditProfileActions({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider = context.watch<ProfileProvider>();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  elevation: 0,
                  backgroundColor: MainTheme.primary(context),
                  foregroundColor: Colors.white
              ),
              onPressed: (){
                profileProvider.setIsEditMode();
              },
              child: const Text(
                "Descartar",
                style: TextStyle(
                    fontSize: 12
                ),
              )
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                elevation: 0,
                backgroundColor: MainTheme.secondary(context),
                foregroundColor: Colors.white
            ),
            onPressed: () async {
              try {
                await profileProvider.updateProfile();
                profileProvider.setIsEditMode();
                await showDialog(
                  context: context,
                  builder: (_) => const CustomDialog(
                    title: "Datos cambiados correctamente",
                    route: "/profile",
                  ),
                );
              } finally{
                profileProvider.setIsEditMode();
              }
            },
            child: const Text(
              "Confirmar",
              style: TextStyle(
                  fontSize: 12
              ),
            ),
          ),

        ],
      ),
    );
  }
}
