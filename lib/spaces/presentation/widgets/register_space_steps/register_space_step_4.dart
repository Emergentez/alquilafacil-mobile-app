import 'package:alquilafacil/public/ui/theme/main_theme.dart';
import 'package:alquilafacil/spaces/presentation/widgets/navigation_buttons.dart';
import 'package:alquilafacil/spaces/presentation/widgets/space_text_form_field.dart';
import 'package:flutter/material.dart';

class RegisterSpaceStep4 extends StatefulWidget {
  final PageController pageController;
  final Function(String, String, String, String, String) onAddressChanged;

  const RegisterSpaceStep4({super.key, required this.pageController, required this.onAddressChanged});

  @override
  _RegisterSpaceStep4State createState() => _RegisterSpaceStep4State();
}

class _RegisterSpaceStep4State extends State<RegisterSpaceStep4> {
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();

  bool canProceed = false;

  @override
  void initState() {
    super.initState();
    _countryController.addListener(_checkFields);
    _cityController.addListener(_checkFields);
    _districtController.addListener(_checkFields);
    _streetController.addListener(_checkFields);
    _numberController.addListener(_checkFields);
  }

  void _checkFields() {
    setState(() {
      canProceed = _countryController.text.isNotEmpty &&
          _cityController.text.isNotEmpty &&
          _districtController.text.isNotEmpty &&
          _streetController.text.isNotEmpty &&
          _numberController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _countryController.dispose();
    _cityController.dispose();
    _districtController.dispose();
    _streetController.dispose();
    _numberController.dispose();
    super.dispose();
  }

  void _notifyAddressChange() {
    widget.onAddressChanged(
      _countryController.text,
      _cityController.text,
      _districtController.text,
      _streetController.text,
      _numberController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(
              padding: const EdgeInsets.only(top:10.0),
              child: Text(
                'Confirma tu dirección',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: MainTheme.contrast(context)),
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Solo compartiremos tu dirección con los que hayan hecho una reservación',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
            ),
            const SizedBox(height: 16.0),
            Column(
              children: [
                SpaceTextFormField(controller: _countryController, label: 'País', hintText: 'Perú'),
                const SizedBox(height: 16.0),
                SpaceTextFormField(controller: _cityController, label: 'Departamento', hintText: 'Lima'),
                const SizedBox(height: 16.0),
                SpaceTextFormField(controller: _districtController, label: 'Distrito', hintText: 'San Isidro'),
                const SizedBox(height: 16.0),
                SpaceTextFormField(controller: _streetController, label: 'Dirección', hintText: 'Avenida General Salaverry'),
                const SizedBox(height: 16.0),
                SpaceTextFormField(controller: _numberController, label: 'Número, edificio, apartamento', hintText: '2255'),
              ],
            ),
            const SizedBox(height: 32.0),
            NavigationButtons(
              pageController: widget.pageController,
              canProceed: canProceed,
              onNext: () {
                _notifyAddressChange();
                widget.pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
              },
            ),
          ],
        ),
      ),
    );
  }
}
