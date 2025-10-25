import 'package:alquilafacil/auth/presentation/providers/SignInProvider.dart';
import 'package:alquilafacil/public/presentation/widgets/custom_dialog.dart';
import 'package:alquilafacil/spaces/presentation/screens/search_spaces.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../public/ui/theme/main_theme.dart';
import '../widgets/auth_text_field.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final signInProvider = context.watch<SignInProvider>();
    return Scaffold(
      backgroundColor: MainTheme.primary(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Center(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text("INICIA SESIÓN",
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 10),
              AuthTextField(
                textLabel: 'Correo electrónico',
                textHint: 'Ingrese correo electrónico',
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
                textLabel: 'Contraseña',
                textHint: 'Ingrese contraseña',
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
                      await showDialog(context: context, builder: (_) => const CustomDialog(title: "Inicio de sesión exitoso", route:"/search-space"));
                    }
                  } catch(_){
                     await showDialog(context: context, builder: (_) => const CustomDialog(title: "Correo electrónico o contraseña incorrectos", route:"/login"));
                  }
                  },
                  child: const Text("Iniciar sesión"),
                ),
              ),
              const SizedBox(height: 20.0),
              Container(
                width: 330,
                height: 1,
                decoration: BoxDecoration(color: MainTheme.background(context)),
              ),
              const SizedBox(height: 20),
              const Text(
                  "¿Aún no tienes cuenta?",
                style: TextStyle(
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
                      child: const Text("Regístrate")
                  ),
              ),

            ],
          ),
        )),
      ),
    );
  }
}
