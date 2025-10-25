import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../public/ui/theme/main_theme.dart';

class EditAccountInfoField extends StatelessWidget {
  final String accountParam;
  final String labelParam;
  final ValueChanged<String> onChangeValue;
  const EditAccountInfoField({super.key, required this.accountParam, required this.labelParam, required this.onChangeValue});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: accountParam,
      onChanged: (newValue){
        onChangeValue(newValue);
      },
      cursorColor: MainTheme.primary(context),
      style: const TextStyle(
          color: Colors.black,
          fontSize: 12
      ),
      decoration:   InputDecoration(
          labelStyle: const TextStyle(
              color: Colors.black,
            fontSize: 12
          ),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: MainTheme.primary(context)
              )
          ),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: MainTheme.primary(context)
              )
          ),
          labelText: labelParam
      ),
    );
  }
}
