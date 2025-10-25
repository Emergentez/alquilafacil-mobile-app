import 'package:alquilafacil/auth/presentation/providers/ConditionTermsProvider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../public/ui/theme/main_theme.dart';

class ConditionsTerms extends StatefulWidget {
  const ConditionsTerms({super.key});

  @override
  State<StatefulWidget> createState() => _ConditionTerms();
}

class _ConditionTerms extends State<ConditionsTerms> {
  @override
  Widget build(BuildContext context) {
    final conditionTermsProvider = context.watch<ConditionTermsProvider>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Checkbox(
          value: conditionTermsProvider.isChecked,
          side: BorderSide(color: MainTheme.secondary(context), width: 2.0),
          activeColor: MainTheme.transparent,
          checkColor: MainTheme.secondary(context),
          onChanged: (_) {
            conditionTermsProvider.setIsChecked();
          },
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(fontSize: 16.0, color: MainTheme.background(context)),
              children: [
                const TextSpan(
                  text: "Al registrarse, acepta los ",
                ),
                TextSpan(
                  text: "Términos de uso",
                  style: TextStyle(color: MainTheme.background(context), fontWeight: FontWeight.bold),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.pushNamed(context, '/terms');
                    },
                ),
                const TextSpan(text: " y la "),
                TextSpan(
                  text: "Política de Privacidad",
                  style: TextStyle(color: MainTheme.background(context), fontWeight: FontWeight.bold),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.pushNamed(context, '/privacy-policy');
                    },
                ),
                const TextSpan(text: " de AlquilaFácil."),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
