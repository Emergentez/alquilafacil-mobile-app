import 'package:alquilafacil/auth/presentation/providers/ConditionTermsProvider.dart';
import 'package:alquilafacil/auth/presentation/providers/SignUpProvider.dart';
import 'package:alquilafacil/profile/presentation/providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import '../../../public/presentation/widgets/custom_dialog.dart';
import '../../../public/ui/theme/main_theme.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/condition_terms.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController captchaController = TextEditingController();
  late String generatedCaptcha;

  String _generateCaptcha() {
  final random = DateTime.now().millisecondsSinceEpoch.remainder(100000);
  return random.toString().padLeft(5, '0');
  }

  @override
  void initState() {
  super.initState();
  generatedCaptcha = _generateCaptcha();
  }

  @override
  Widget build(BuildContext context) {
    final signUpProvider = context.watch<SignUpProvider>();
    final profileProvider = context.watch<ProfileProvider>();
    final conditionTermsProvider = context.watch<ConditionTermsProvider>();
    return Scaffold(
        backgroundColor: MainTheme.primary(context),
        body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 10),
            child: SingleChildScrollView(
              child: Center(
              child: Column(
                children: <Widget>[
                  const Text(
                    "REGÍSTRATE",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0, color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  AuthTextField(
                    textLabel: "Nombre de usuario",
                    textHint: "Ingrese su nombre de usuario",
                    isPassword: false,
                    param: signUpProvider.username,
                    onChanged: (newValue) {
                      signUpProvider.setUsername(newValue);
                    },
                    validator: (_) {
                      return signUpProvider.validateUsername();
                    },
                  ),
                  const SizedBox(height: 10),
                  AuthTextField(
                    textLabel: "Nombre",
                    textHint: "Ingrese su nombre",
                    isPassword: false,
                    param: signUpProvider.name,
                    onChanged: (newValue) {
                      signUpProvider.setName(newValue);
                    },
                    validator: (_) {
                      return signUpProvider.validateName();
                    },
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: AuthTextField(
                          textLabel: "Apellido paterno",
                          textHint: "Ingrese su apellido paterno:",
                          isPassword: false,
                          param: signUpProvider.fatherName,
                          onChanged: (newValue) {
                            signUpProvider.setFatherName(newValue);
                          },
                          validator: (_) {
                            return signUpProvider.validateName();
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: AuthTextField(
                          textLabel: "Apellido materno",
                          textHint: "Ingrese su apellido materno:",
                          isPassword: false,
                          param: signUpProvider.motherName,
                          onChanged: (newValue) {
                            signUpProvider.setMotherName(newValue);
                          },
                          validator: (_) {
                            return signUpProvider.validateName();
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: AuthTextField(
                          textLabel: "Número de telefono",
                          textHint: "Ingrese su número de telefono",
                          isPassword: false,
                          param: profileProvider.phoneNumber,
                          onChanged: (newValue) {
                            signUpProvider.setPhone(newValue);
                          },
                          validator: (_) {
                            return signUpProvider.validatePhoneNumber();
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: AuthTextField(
                          textLabel: "Número de documento",
                          textHint: "Ingrese su número de documento",
                          isPassword: false,
                          param: signUpProvider.documentNumber,
                          onChanged: (newValue) {
                            signUpProvider.setDocumentNumber(newValue);
                          },
                          validator: (_) {
                            return signUpProvider.validateDocumentNumber();
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  AuthTextField(
                    textLabel: "Fecha de nacimiento",
                    textHint: "DD/MM/YY",
                    isPassword: false,
                    param: signUpProvider.dateOfBirth,
                    onChanged: (newValue) {
                      final parsedDate = DateFormat('dd/MM/yy').parse(newValue);
                      signUpProvider.setDateOfBirth(parsedDate);
                    },
                    validator: (_) {
                      return signUpProvider.validateDateOfBirth();
                    }
                  ),
                  const SizedBox(height: 10),
                  AuthTextField(
                    textLabel: "Correo electrónico",
                    textHint: "Ingrese su correo electrónico",
                    isPassword: false,
                    param: signUpProvider.email,
                    onChanged: (newValue) {
                      signUpProvider.setEmail(newValue);
                    },
                    validator: (_) {
                      return signUpProvider.validateEmail();
                    },
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: <Widget> [
                      Expanded(
                        flex: 1,
                        child: AuthTextField(
                          textLabel: "Contraseña",
                          textHint: "Ingrese su contraseña",
                          isPassword: true,
                          param: signUpProvider.password,
                          onChanged: (newValue) {
                            signUpProvider.setPassword(newValue);
                          },
                          validator: (_) {
                            return signUpProvider.validatePassword();
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: AuthTextField(
                          textLabel: "Escriba nuevamente su contraseña",
                          textHint: "Escriba nuevamente su contraseña",
                          isPassword: true,
                          param: signUpProvider.confirmPassword,
                          onChanged: (newValue) {
                            signUpProvider.setConfirmPassword(newValue);
                          },
                          validator: (_) {
                            return signUpProvider.validateConfirmPassword();
                          },
                        ),
                      ),
                    ]
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    decoration: BoxDecoration(
                      color: MainTheme.background(context),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      generatedCaptcha,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                        color: MainTheme.contrast(context),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: captchaController,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 12),
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Escribe el captcha',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const ConditionsTerms(),
                  const SizedBox(height: 15),
                  SizedBox(
                      width: 330,
                      height: 50,
                      child: TextButton(
                        onPressed: () async {
                          try {
                            if (!conditionTermsProvider.isChecked) {
                              await showDialog(context: context, builder: (_) => const CustomDialog(title: "Por favor, acepte nuestras políticas de uso", route:"/sign-up"));
                            } else {
                                await signUpProvider.signUp();
                                if (signUpProvider.successfulMessage.isNotEmpty) {
                                  await showDialog(context: context, builder: (_) => const CustomDialog(title: "Registro exitoso", route:"/login"));
                                } else{
                                  await showDialog(context: context, builder: (_) => const CustomDialog(title: "Usuario ya existente o datos incorrectos", route:"/sign-up"));
                                }
                            }
                          } catch (e) {
                            Logger().e("Error during registration: $e");
                            await showDialog(context: context, builder: (_) => const CustomDialog(title: "Ocurrió un error en el registro", route:"/sign-up"));
                          }
                        },
                        child: const Text("Regístrate ahora"),
                      )),
                  const SizedBox(height: 10),
                  Container(
                    width: 330,
                    height: 1,
                    decoration: BoxDecoration(color: MainTheme.background(context)),
                  ),
                  const SizedBox(height: 25),
                  const Text(
                      "¿Ya tienes cuenta?",
                      style: TextStyle(
                          fontSize: 10.0, color: Colors.white
                      )
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 330,
                    height: 50,
                    child: TextButton(
                      onPressed: ()=>{ Navigator.pushReplacementNamed(context, "/login")},
                      child: const Text("Inicia sesión"),
                    )
                  ),
                ],
              ),
            ))));
  }
}
