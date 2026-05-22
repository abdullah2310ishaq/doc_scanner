import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  ImagePickerService({ImagePicker? picker}) : _picker = picker ?? ImagePicker();

  final ImagePicker _picker;

  Future<String?> pickImageFromGallery() async {
    final file = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );
    return file?.path;
  }

  /// Picks up to [max] images from the gallery (multi-select when supported).
  Future<List<String>> pickMultipleImagesFromGallery({int max = 8}) async {
    final files = await _picker.pickMultiImage(
      imageQuality: 100,
      limit: max,
    );
    return files.map((file) => file.path).toList();
  }
}
