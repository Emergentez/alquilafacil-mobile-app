import 'package:alquilafacil/profile/data/remote/helpers/user_service_helper.dart';
import 'package:alquilafacil/profile/domain/model/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class ProfileProvider extends ChangeNotifier {
  String usernameExpect = "";
  String name = "";
  String fatherName = "";
  String motherName = "";
  String documentNumber = "";
  String dateOfBirth = "";
  String phoneNumber = "";
  String bankAccount = "";
  String interbankAccount = "";
  bool isEditMode = false;


  String currentName = "";
  String currentFatherName = "";
  String currentMotherName = "";
  String currentDocumentNumber = "";
  String currentPhoneNumber = "";
  String currentDateOfBirth = "";

  Profile? currentProfile;
  List<dynamic> usernamesExpect = [];
  final UserServiceHelper userServiceHelper;

  ProfileProvider(this.userServiceHelper);

  void setIsEditMode(){
    isEditMode = !isEditMode;
    notifyListeners();
  }


  void setName(String value) {
    name = value;
    notifyListeners();
  }

  void setFatherName(String value) {
    fatherName = value;
    notifyListeners();
  }

  void setMotherName(String value) {
    motherName = value;
    notifyListeners();
  }


  void setDocumentNumber(String value) {
    documentNumber = value;
    notifyListeners();
  }

  void setDateOfBirth(DateTime date) {
    final dateFormat = DateFormat('dd/MM/yy');
    final formattedDate = dateFormat.format(date);
    dateOfBirth = formattedDate;
    notifyListeners();
  }

  void setPhoneNumber(String value) {
    phoneNumber = value;
    notifyListeners();
  }

  void setBankAccount(String value) {
    bankAccount = value;
    notifyListeners();
  }

  void setInterbankAccount(String value) {
    interbankAccount = value;
    notifyListeners();
  }

  void setCurrentName(String value) {
    currentName = value;
    notifyListeners();
  }

  void setCurrentFatherName(String value) {
    currentFatherName = value;
    notifyListeners();
  }

  void setCurrentMotherName(String value) {
    currentMotherName = value;
    notifyListeners();
  }


  void setCurrentDocumentNumber(String value) {
    currentDocumentNumber = value;
    notifyListeners();
  }

  void setCurrentDateOfBirth(String value) {
    currentDateOfBirth = value;
    notifyListeners();
  }

  void setCurrentPhoneNumber(String value) {
    currentPhoneNumber = value;
    notifyListeners();
  }

  String? validatePhoneNumber(){
    if (phoneNumber.length != 9){
      return "El número de contacto debe ser de 9 digitos";
    }
    else{
      return null;
    }
  }

  String? validateName(){
    if (name.isEmpty || motherName.isEmpty || fatherName.isEmpty ){
      return "${name.isEmpty ? "Nombre": "Apellido paterno y materno"}  es un campo requerido";
    }
    else{
      return null;
    }
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
    final currentDate = DateTime.now();
    if (DateTime(2000 + year, month, day).isAfter(currentDate)) {
      return "La fecha de nacimiento no puede ser en el futuro.";
    }

    return null;
  }

  Future<void> updateProfile() async {
    var profileId = currentProfile!.id;
    var profileToUpdate = {
      "name": currentName,
      "fatherName": currentFatherName,
      "motherName": currentMotherName,
      "phone":currentPhoneNumber,
      "documentNumber": currentDocumentNumber,
      "dateOfBirth": currentDateOfBirth,
      "bankAccountNumber": bankAccount,
      "interbankAccountNumber": interbankAccount,
    };
    currentProfile = await userServiceHelper.updateProfile(profileId, profileToUpdate);
    notifyListeners();
  }

  Future<void> fetchProfileByUserId(int userId) async {
    try {
      currentProfile = await userServiceHelper.getProfileByUserId(userId);

    } catch (_){
      Logger().e("Error while trying to fecth profile by user id");
    }
    notifyListeners();
  }

  Future<void> fetchBankAccountsByUserId(int userId) async {
    try {
      List<String> bankAccounts = await userServiceHelper.getBankAccountsByUserId(userId);
      bankAccount = bankAccounts[0];
      interbankAccount = bankAccounts[1];
    } catch (_) {
      Logger().e("Error while trying to fetch bank accounts");
    }
    notifyListeners();
  }

  Future<void> fetchUsernameExpect(int userId) async {
    try {
      usernameExpect = await userServiceHelper.getUsernameByUserId(userId);
    } catch (_) {
      Logger().e("Error while trying to fetch username");
    }
    notifyListeners();
  }

  Future<void> fetchUsernamesExpect(List<dynamic> userIds) async {
    try {
      usernamesExpect = [];
      for (int i = 0; i < userIds.length; i++) {
        usernameExpect = await userServiceHelper.getUsernameByUserId(userIds[i]);
        usernamesExpect.add(usernameExpect);
      }
    } catch (_) {
      Logger().e("Error while trying to fetch username");
    }
    notifyListeners();
  }
}
