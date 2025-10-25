import 'package:alquilafacil/public/ui/theme/main_theme.dart';
import 'package:flutter/material.dart';

class SpaceTextFormField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller; // Añadir el controlador
  final Function(String)? onChanged; // Añadir el callback onChanged

  const SpaceTextFormField({
    super.key,
    required this.label,
    required this.hintText,
    this.controller, // Incluir el controlador opcional
    this.onChanged,  // Incluir el callback opcional
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller, // Asignar el controlador al TextFormField
        cursorColor: MainTheme.primary(context),
        style: TextStyle(color: MainTheme.contrast(context)),
        decoration: InputDecoration(
          labelText: label,
          labelStyle:  TextStyle(
            color: MainTheme.contrast(context),
            fontSize: 16.0,
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 14.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              color: Colors.black,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: MainTheme.contrast(context),
              width: 1.0,
            ),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
