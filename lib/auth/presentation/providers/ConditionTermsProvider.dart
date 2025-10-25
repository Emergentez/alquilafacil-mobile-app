import 'package:flutter/material.dart';

class ConditionTermsProvider extends ChangeNotifier{
  bool isChecked = false;

  void setIsChecked(){
    isChecked = !isChecked;
    notifyListeners();
  }
}