import 'package:alquilafacil/auth/presentation/providers/SignInProvider.dart';
import 'package:alquilafacil/public/presentation/widgets/custom_dialog.dart';
import 'package:alquilafacil/spaces/presentation/screens/search_spaces.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../../public/ui/theme/main_theme.dart';
import '../widgets/auth_text_field.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final signInProvider = context.watch<SignInProvider>();
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: MainTheme.primary(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Center(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(l10n.loginTitle,
                  style: const TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 10),
              AuthTextField(
                textLabel: l10n.email,
                textHint: l10n.email,
                isPassword: false,
                param: signInProvider.email,
                onChanged: (newEmail) {
                  signInProvider.setEmail(newEmail);
                },
                validator: (_) {
                  return signInProvider.validateEmail();
                },
              ),
              const SizedBox(height: 10),
              AuthTextField(
                textLabel: l10n.password,
                textHint: l10n.password,
                isPassword: true,
                param: signInProvider.password,
                onChanged: (newPassword) {
                  signInProvider.setPassword(newPassword);
                },
                validator: (_) {
                  return signInProvider.validatePassword();
                },
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: 400,
                height: 50,
                child: TextButton(
                  onPressed: () async  {
                  try{
                    await signInProvider.signIn();
                    if(signInProvider.token.isNotEmpty){
                      await showDialog(context: context, builder: (_) => CustomDialog(title: l10n.reservationSuccess, route:"/search-space"));
                    }
                  } catch(_){
                     await showDialog(context: context, builder: (_) => CustomDialog(title: l10n.invalidCredentials, route:"/login"));
                  }
                  },
                  child: Text(l10n.loginButton),
                ),
              ),
              const SizedBox(height: 20.0),
              Container(
                width: 330,
                height: 1,
                decoration: BoxDecoration(color: MainTheme.background(context)),
              ),
              const SizedBox(height: 20),
              Text(
                  l10n.noAccount,
                style: const TextStyle(
                  fontSize: 10.0,
                  color: Colors.white
                )
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 400,
                height: 50,
                  child: TextButton(
                      onPressed: (){
                        Navigator.pushReplacementNamed(context, "/sign-up");
                      },
                      child: Text(l10n.registerButton)
                  ),
              ),

            ],
          ),
        )),
      ),
    );
  }
}
