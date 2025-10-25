import 'package:alquilafacil/auth/shared/AuthFilter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import '../../data/remote/helpers/auth_service_helper.dart';

class SignUpProvider extends ChangeNotifier with AuthFilter {
  String username = "";
  String email = "";
  String password = "";
  String confirmPassword = "";
  String name = "";
  String fatherName = "";
  String motherName = "";
  String dateOfBirth = "";
  String documentNumber = "";
  String phone = "";
  String successfulMessage = "";
  final logger = Logger();
  final AuthServiceHelper serviceHelper;
  SignUpProvider(this.serviceHelper);


  @override
  String? validateEmail() {
    if (email.isEmpty) {
      return "El email es requerido";
    }
    if (!email.contains('@')) {
      return "Por favor, ingrese un email valido";
    }
    return null;
  }

  @override
  String? validatePassword() {
    if (password.isEmpty) {
      return "Por favor ingrese una contraseña valida";
    }
    if (password.length < 8) {
      return "La contraseña debe tener como minimo 8 caracteres";
    }
    if(password == "12345678"){
      return "La contraseña no puede ser 12345678";
    }
    return null;
  }


  String? validateConfirmPassword() {
    if (confirmPassword != password) {
      return 'Las contraseñas no coinciden';
    }
    if (confirmPassword.isEmpty) {
      return "Por favor ingrese una contraseña valida";
    }
    if (confirmPassword.length < 8) {
      return "La contraseña debe tener como minimo 8 caracteres";
    }
    if(confirmPassword == "12345678"){
      return "La contraseña no puede ser 12345678";
    }
    return null;
  }

  String? validateUsername(){
    if(username.isEmpty){
      return "Por favor ingrese un nombre de usuario";
    }
    return null;
  }

  String? validateName(){
    if(name.isEmpty){
      return "Por favor ingrese su nombre";
    }
    return null;
  }

  String? validateFatherName(){
    if(fatherName.isEmpty){
      return "Por favor ingrese su apellido paterno";
    }
    return null;
  }

  String? validateMotherName(){
    if(motherName.isEmpty){
      return "Por favor ingrese su apellido materno";
    }
    return null;
  }

  String? validateDateOfBirth() {
    final regex = RegExp(r'^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/\d{2}$');

    if (!regex.hasMatch(dateOfBirth)) {
      return "La fecha debe estar en el formato DD/MM/YY";
    }

    final parts = dateOfBirth.split('/');
    final day = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final year = int.parse(parts[2]);


    try {
      final validDate = DateTime(2000 + year, month, day);
      if (validDate.day != day || validDate.month != month) {
        return "La fecha no es válida.";
      }
    } catch (e) {
      return "La fecha no es válida.";
    }


    return null;
  }

  String? validateDocumentNumber(){
    if(documentNumber.isEmpty){
      return "Por favor ingrese su numero de documento";
    }
    if(documentNumber.length < 8){
      return "El numero de documento debe tener como minimo 8 caracteres";
    }
    return null;
  }

  String? validatePhoneNumber(){
    if (phone.length != 9){
      return "El número de contacto debe ser de 9 digitos";
    }
    else{
      return null;
    }
  }

  void setEmail(String newEmail) {
    email = newEmail;
    notifyListeners();
  }

  void setPassword(String newPassword) {
    password = newPassword;
    notifyListeners();
  }

  void setUsername(String newUsername){
    username = newUsername;
    notifyListeners();
  }

  void setSuccessfulMessage(String messageResponse){
    successfulMessage = messageResponse;
    notifyListeners();
  }

  void setConfirmPassword(String newConfirmPassword) {
    confirmPassword = newConfirmPassword;
    notifyListeners();
  }

  void setName(String newName) {
    name = newName;
    notifyListeners();
  }

  void setFatherName(String newFatherName) {
    fatherName = newFatherName;
    notifyListeners();
  }

  void setMotherName(String newMotherName) {
    motherName = newMotherName;
    notifyListeners();
  }

  void setDateOfBirth(DateTime date) {
    final dateFormat = DateFormat('dd/MM/yy');
    final formattedDate = dateFormat.format(date);
    dateOfBirth = formattedDate;
    notifyListeners();
  }

  void setDocumentNumber(String newDocumentNumber) {
    documentNumber = newDocumentNumber;
    notifyListeners();
  }

  void setPhone(String newPhone) {
    phone = newPhone;
    notifyListeners();
  }

  Future signUp() async {
    var message = await serviceHelper.signUp(username, password, email, name, fatherName, motherName, dateOfBirth, documentNumber, phone);
    setSuccessfulMessage(message);
    notifyListeners();
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      throw Exception("Google sign-in failed");
    }
    final GoogleSignInAuthentication? authentication = await googleUser.authentication;
    if (authentication == null) {
      throw Exception("Failed to get authentication credentials from Google");
    }

    final credentials = GoogleAuthProvider.credential(
      accessToken: authentication.accessToken,
      idToken: authentication.idToken,
    );

    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credentials);
    return userCredential;
  }

  Future<UserCredential> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final AccessToken? accessToken = result.accessToken;
        final OAuthCredential credential = FacebookAuthProvider.credential(accessToken!.token);
        UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
        return userCredential;
      } else {
        throw Exception("Sign in with facebook was failed: ${result.status}");
      }
    } catch (e) {
      logger.e("Error while trying to sign in with facebook: $e");
      rethrow;
    }
  }

}
