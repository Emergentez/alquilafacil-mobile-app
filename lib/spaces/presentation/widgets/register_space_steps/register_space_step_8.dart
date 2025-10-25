import 'package:alquilafacil/public/ui/theme/main_theme.dart';
import 'package:alquilafacil/spaces/presentation/widgets/navigation_buttons.dart';
import 'package:flutter/material.dart';

class RegisterSpaceStep8 extends StatefulWidget {
  final PageController pageController;
  final int price;
  final Function(int) onPriceChanged;

  const RegisterSpaceStep8({
    super.key,
    required this.pageController,
    required this.price,
    required this.onPriceChanged,
  });

  @override
  _RegisterSpaceStep8State createState() => _RegisterSpaceStep8State();
}

class _RegisterSpaceStep8State extends State<RegisterSpaceStep8> {
  late TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    _priceController = TextEditingController(text: widget.price.toString()); // Convertir int a String
  }

  @override
  void dispose() {
    _priceController.dispose();
    super.dispose();
  }

  void _updatePrice(String value) {
    // Aquí puedes manejar la conversión, pero ya no llamas a onPriceChanged
    int? newPrice = int.tryParse(value);
    if (newPrice != null) {
      // Actualiza el controlador solo si hay un valor válido
      _priceController.text = newPrice.toString();
    }
  }

  void _savePrice() {
    // Guarda el precio solo cuando se presiona el botón de navegación
    int? savedPrice = int.tryParse(_priceController.text);
    if (savedPrice != null) {
      widget.onPriceChanged(savedPrice);
    } else {
      widget.onPriceChanged(0); // O manejar de otra forma si es necesario
    }
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
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                'Ponle un precio a tu espacio',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: MainTheme.contrast(context),
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Podrás cambiarlo en cualquier momento',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.normal,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 32),
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 1,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'S/. ',
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _priceController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(

                          hintText: 'Precio por hora',
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        onChanged: _updatePrice,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            const Center(
              child: Text(
                'por hora',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            NavigationButtons(
              pageController: widget.pageController,
              onNext: _savePrice, // Aquí pasas el método para guardar el precio
            ),
          ],
        ),
      ),
    );
  }
}