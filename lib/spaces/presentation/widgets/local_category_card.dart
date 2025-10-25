import 'package:alquilafacil/public/ui/theme/main_theme.dart';
import 'package:flutter/material.dart';

class LocalCategoryCard extends StatelessWidget {
  final int id;
  final String name;
  final String photoUrl;
  final bool isSelected;
  final VoidCallback onSelect;

  const LocalCategoryCard({
    super.key,
    required this.id,
    required this.name,
    required this.photoUrl,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
        child: FractionallySizedBox(
          widthFactor: 0.8,
          heightFactor: 0.9,
          child: Card(
            elevation: 5,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
              side: BorderSide(
                color: isSelected
                    ? MainTheme.primary(context)
                    : Colors.transparent,
                width: 2,
              ),
            ),
            child: Container(
              constraints: const BoxConstraints(
                minHeight: 200.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Image.network(
                        photoUrl,
                        fit: BoxFit.contain,
                        width: double.infinity,
                        height: 180,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    child: Text(
                      name,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}