

import 'package:alquilafacil/auth/data/remote/helpers/auth_service_helper.dart';
import 'package:alquilafacil/auth/shared/AuthFilter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInProvider extends ChangeNotifier with AuthFilter {
  String email = "";
  String password = "";
  String token = "";
  int userId = 0;
  final logger = Logger();
  final AuthServiceHelper authServiceHelper;

  SignInProvider(this.authServiceHelper) {
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString("token") ?? "";
    userId = sharedPreferences.getInt("userId") ?? 0;
    notifyListeners();
  }

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
    return null;
  }

  void setEmail(String newEmail) {
    email = newEmail;
    notifyListeners();
  }

  Future<void> setUserId(int id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setInt("userId", id);
    userId = id;
    notifyListeners();
  }

  Future<void> setToken(String newToken) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString("token", newToken);
    token = newToken;
    notifyListeners();
  }

  void setPassword(String newPassword) {
    password = newPassword;
    notifyListeners();
  }

  Future<void> onLogOutRequest() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove("token");
    await sharedPreferences.remove("userId");
    token = "";
    userId = 0;
    notifyListeners();
  }

  Future<bool> onSessionActive() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool isSessionActive = sharedPreferences.get("token") != null;
    return isSessionActive;
  }

  Future<void> signIn() async {
    var json = await authServiceHelper.signIn(email, password);
    var token = json["token"];
    var userId = json["id"];
    setUserId(userId);
    setToken(token);
    notifyListeners();
  }

  Future<UserCredential> signInWithGoogle() async{
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
