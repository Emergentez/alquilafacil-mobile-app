import 'package:flutter/material.dart';

import '../../../public/ui/theme/main_theme.dart';

class AuthTextField extends StatefulWidget {
  final String textLabel;
  final String textHint;
  final bool isPassword;
  final String param;
  final ValueChanged<String> onChanged;
  final FormFieldValidator<String>? validator;
  const AuthTextField({
    super.key,
    required this.textLabel,
    required this.textHint,
    required this.isPassword,
    required this.param,
    required this.onChanged,
    this.validator,
  });
  @override
  State<StatefulWidget> createState() => _AuthTextField();
}

class _AuthTextField extends State<AuthTextField> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          color: MainTheme.background(context),
          borderRadius: const BorderRadius.all(Radius.circular(10.0))),
      child: Form(
        key: _formKey,
        child: TextFormField(
          initialValue: widget.param,
          onChanged: (newValue) {
            setState(() {
              widget.onChanged(newValue);
            });
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: widget.validator,
          obscureText: widget.isPassword,
          cursorColor: MainTheme.contrast(context),
          style: TextStyle(color: MainTheme.contrast(context), fontSize: 12.0),
          decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: MainTheme.transparent)),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: MainTheme.primary(context)),
              ),
              labelStyle: TextStyle(color: MainTheme.helper(context), fontSize: 12.0),
              errorStyle: const TextStyle(fontSize: 7.0),
              label: Text(widget.textLabel),
              hintText: widget.textHint,
              hintStyle: TextStyle(color: MainTheme.helper(context), fontSize: 10.0)),
        ),
      ),
    );
  }
}
