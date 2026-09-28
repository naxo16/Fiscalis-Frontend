import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Servicio para la captura y persistencia segura de imágenes.
/// Mantiene las fotos dentro del sandbox de la aplicación (Documents Directory).
class ImageService {
  final ImagePicker _picker = ImagePicker();

  Future<String?> takeAndSavePhoto() async {
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
    );

    if (photo == null) return null;

    final directory = await getApplicationDocumentsDirectory();
    final String fileName = 'IMG_${DateTime.now().millisecondsSinceEpoch}${p.extension(photo.path)}';
    final String savedPath = p.join(directory.path, 'fotos_infracciones', fileName);

    // Asegurar que el subdirectorio exista
    final subDir = Directory(p.join(directory.path, 'fotos_infracciones'));
    if (!await subDir.exists()) await subDir.create(recursive: true);

    final File savedImage = await File(photo.path).copy(savedPath);
    return savedImage.path;
  }
}

final imageServiceProvider = Provider((ref) => ImageService());
