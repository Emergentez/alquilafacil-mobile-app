import 'package:alquilafacil/spaces/presentation/widgets/navigation_buttons.dart';
import 'package:flutter/material.dart';
import 'package:alquilafacil/spaces/presentation/widgets/space_text_form_field.dart';

import '../../../../public/ui/theme/main_theme.dart';

class RegisterSpaceStep7 extends StatefulWidget {
  final PageController pageController;
  final String localName;
  final String descriptionMessage;
  final String capacity;
  final String features;
  final Function(String, String, String, String) onStepDataChanged;

  const RegisterSpaceStep7({
    super.key,
    required this.pageController,
    required this.localName,
    required this.descriptionMessage,
    required this.capacity,
    required this.features,
    required this.onStepDataChanged,
  });

  @override
  _RegisterSpaceStep7State createState() => _RegisterSpaceStep7State();
}

class _RegisterSpaceStep7State extends State<RegisterSpaceStep7> {
  late TextEditingController _localNameController;
  late TextEditingController _descriptionMessageController;
  late TextEditingController _capacityController;
  List<String> _selectedFeatures = [];

  @override
  void initState() {
    super.initState();
    _localNameController = TextEditingController(text: widget.localName);
    _descriptionMessageController =
        TextEditingController(text: widget.descriptionMessage);
    _capacityController = TextEditingController(text: widget.capacity);
    _selectedFeatures =
        widget.features.split(',').where((f) => f.isNotEmpty).toList();
  }

  void _onFeatureAdded(String feature) {
    setState(() {
      _selectedFeatures.add(feature);
      _updateParent();
    });
  }

  void _onFeatureRemoved(int index) {
    setState(() {
      _selectedFeatures.removeAt(index);
      _updateParent();
    });
  }

  void _updateParent() {
    widget.onStepDataChanged(
      _localNameController.text,
      _descriptionMessageController.text,
      _capacityController.text,
      _selectedFeatures.join(','),
    );
  }

  bool get canProceed {
    return _localNameController.text.isNotEmpty &&
        _descriptionMessageController.text.isNotEmpty &&
        _capacityController.text.isNotEmpty &&
        _selectedFeatures.isNotEmpty;
  }

  void _showAddFeatureDialog() {
    TextEditingController featureController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Agregar característica', style: TextStyle(color: MainTheme.contrast(context))),
          content: TextField(
            style: const TextStyle(color: Colors.black),
            controller: featureController,
            decoration: const InputDecoration(
              hintText: 'Ingrese la característica',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Agregar'),
              onPressed: () {
                String newFeature = featureController.text.trim();
                if (newFeature.isNotEmpty) {
                  _onFeatureAdded(newFeature);
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

             Padding(
               padding: const EdgeInsets.only(top: 10.0),
               child: Text(
                'Ahora, añade los detalles de tu espacio',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: MainTheme.contrast(context),
                ),
                           ),
             ),
            const SizedBox(height: 8),
            const Text(
              'Los títulos cortos funcionan mejor.\nNo te preocupes, puedes modificarlo más adelante.',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 16),
            SpaceTextFormField(
              label: 'Nombre',
              hintText: 'Salón recreativo "Los Pinos"',
              controller: _localNameController,
              onChanged: (value) => _updateParent(),
            ),
            const SizedBox(height: 16),
            SpaceTextFormField(
              label: 'Descripción',
              hintText: 'Lugar ideal para eventos familiares y corporativos...',
              controller: _descriptionMessageController,
              onChanged: (value) => _updateParent(),
            ),
            const SizedBox(height: 32),
            Text(
              'Aforo (personas)',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: MainTheme.contrast(context),
              ),
            ),
            TextFormField(
              style: const TextStyle(color: Colors.black),
              controller: _capacityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Ingrese el aforo',
              ),
              onChanged: (value) => _updateParent(),
            ),
            const SizedBox(height: 32),
            _buildFeatures(),
            const SizedBox(height: 16),
            NavigationButtons(pageController: widget.pageController, canProceed: canProceed),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatures() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Características',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: MainTheme.contrast(context),
              ),
            ),
            IconButton(
              onPressed: () {
                _showAddFeatureDialog();
              },
              icon: const Icon(Icons.add_circle_outline),
            ),
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _selectedFeatures.length,
          itemBuilder: (context, index) {
            return ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Text(
                '• ${_selectedFeatures[index]}',
                style: const TextStyle(fontSize: 20),
              ),
              trailing: IconButton(
                onPressed: () => _onFeatureRemoved(index),
                icon: const Icon(Icons.delete),
              ),
            );
          },
        ),
      ],
    );
  }
}