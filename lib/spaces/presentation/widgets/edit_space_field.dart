import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../public/ui/theme/main_theme.dart';

class EditSpaceField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<dynamic> onValueChanged;
  final String hintText;
  const EditSpaceField({super.key, required this.controller, required this.onValueChanged, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: MainTheme.primary(context),
      onChanged: (newValue){
        onValueChanged(newValue);
      },
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: MainTheme.primary(context))),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: MainTheme.primary(context))),
      ),
      style: TextStyle(color: MainTheme.contrast(context)),
    );
  }
}
