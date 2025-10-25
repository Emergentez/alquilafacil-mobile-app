import 'package:alquilafacil/spaces/presentation/widgets/local_category_card.dart';
import 'package:alquilafacil/spaces/presentation/widgets/navigation_buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../public/ui/theme/main_theme.dart';
import '../../providers/local_categories_provider.dart';

class RegisterSpaceStep3 extends StatefulWidget {
  final PageController pageController;
  final ValueChanged<int> onCategorySelected;

  const RegisterSpaceStep3({
    super.key,
    required this.pageController,
    required this.onCategorySelected,
  });

  @override
  _RegisterSpaceStep3State createState() => _RegisterSpaceStep3State();
}

class _RegisterSpaceStep3State extends State<RegisterSpaceStep3> {
  int? _selectedCategoryId;
  bool _canProceed = false;

  // Método para actualizar la selección
  void _selectCategory(int id) {
    setState(() {
      _selectedCategoryId = id;
      _canProceed = true;
    });
    widget.onCategorySelected(id);
  }

  @override
  Widget build(BuildContext context) {
    final localCategoriesProvider = context.watch<LocalCategoriesProvider>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child:  Text(
                '¿Cuál de estas opciones describe mejor tu espacio?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: MainTheme.contrast(context)
                ),
              ),
            ),
            const SizedBox(height: 16),
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.0,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: localCategoriesProvider.localCategories.length,
              itemBuilder: (context, index) {
                final category = localCategoriesProvider.localCategories[index];
                return LocalCategoryCard(
                  id: category.id,
                  name: category.name,
                  photoUrl: category.photoUrl,
                  isSelected: _selectedCategoryId == category.id,
                    onSelect: () => _selectCategory(category.id)
                );
              },
            ),
            const SizedBox(height: 16),
            // Pasar el valor de canProceed al widget de navegación
            NavigationButtons(
              pageController: widget.pageController,
              canProceed: _canProceed, // Controla si el botón está habilitado
            ),
          ],
        ),
      ),
    );
  }
}