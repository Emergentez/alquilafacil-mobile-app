import 'package:alquilafacil/auth/presentation/providers/SignInProvider.dart';
import 'package:alquilafacil/auth/presentation/screens/login.dart';
import 'package:alquilafacil/auth/presentation/screens/register.dart';
import 'package:alquilafacil/profile/presentation/providers/profile_provider.dart';
import 'package:alquilafacil/public/ui/theme/main_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileActions extends StatelessWidget {
  const ProfileActions({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider = context.watch<ProfileProvider>();
    final signInProvider = context.watch<SignInProvider>();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                elevation: 0,
                backgroundColor: MainTheme.secondary(context),
                foregroundColor: Colors.white
              ),
                onPressed: (){
                  profileProvider.setIsEditMode();
                },
                child: const Text(
                  "Editar datos",
                  style: TextStyle(
                      fontSize: 12
                  ),
                ),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                  elevation: 0,
                    backgroundColor: MainTheme.primary(context),
                    foregroundColor: Colors.white
                ),
                onPressed: () async {
                  try{
                    await signInProvider.onLogOutRequest();
                  } finally{
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const Login()));
                  }
                },
                child: const Text(
                    "Cerrar sesión",
                  style: TextStyle(
                    fontSize: 12
                  ),
                )
            )
          ],
        ),
    );
  }
}
