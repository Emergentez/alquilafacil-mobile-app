import 'dart:io';
import 'package:alquilafacil/public/ui/theme/main_theme.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:alquilafacil/spaces/presentation/providers/space_provider.dart';
import 'package:alquilafacil/spaces/presentation/widgets/navigation_buttons.dart';

class RegisterSpaceStep6 extends StatefulWidget {
  final PageController pageController;
  final List<String> photoUrls;
  final Function(List<String>) onPhotosChanged;

  const RegisterSpaceStep6({
    super.key,
    required this.pageController,
    required this.photoUrls,
    required this.onPhotosChanged,
  });

  @override
  _RegisterSpaceStep6State createState() => _RegisterSpaceStep6State();
}

class _RegisterSpaceStep6State extends State<RegisterSpaceStep6> {
  List<File> _imageFiles = [];
  bool _canProceed = false;

  Future<void> _pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> pickedFiles = await picker.pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      setState(() {
        _imageFiles = pickedFiles.map((xFile) => File(xFile.path)).toList();
        _canProceed = true;
      });
    }
  }

  // Método para subir la imagen a Cloudinary
  Future<void> _uploadImagesToCloudinary() async {
    final spaceProvider = context.read<SpaceProvider>();
    await spaceProvider.uploadImages(_imageFiles);
    widget.onPhotosChanged(spaceProvider.spacePhotoUrls);
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
                'Agrega una foto de tu espacio',
                style: TextStyle(
                    fontSize: 28, fontWeight: FontWeight.bold, color: MainTheme.contrast(context)),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Selecciona una imagen de la galería para que represente tu espacio.',
              style: TextStyle(
                  color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 32),
            Center(
              child: GestureDetector(
                onTap: _pickImages,
                child: _imageFiles.isEmpty && widget.photoUrls.isEmpty
                    ? Container(
                  width: 250,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_a_photo_outlined,
                          color: MainTheme.primary(context), size: 40),
                      const SizedBox(height: 8),
                      const Text(
                        'Añadir imágenes',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ],
                  ),
                )
                    : ClipRRect(
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _imageFiles.isNotEmpty
                        ? _imageFiles.length
                        : widget.photoUrls.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4),
                    itemBuilder: (context, index) {
                      final isLocal = _imageFiles.isNotEmpty;
                      return isLocal
                          ? Image.file(_imageFiles[index], fit: BoxFit.cover)
                          : Image.network(widget.photoUrls[index], fit: BoxFit.cover);
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            NavigationButtons(
              pageController: widget.pageController,
              canProceed: _canProceed,
              onNext: _uploadImagesToCloudinary,
            ),
          ],
        ),
      ),
    );
  }
}
