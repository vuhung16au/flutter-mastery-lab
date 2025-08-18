import 'dart:io';

import 'package:image_picker/image_picker.dart';

class MediaService {
  final ImagePicker picker;
  MediaService({ImagePicker? picker}) : picker = picker ?? ImagePicker();

  Future<File?> pickImageFromGallery() async {
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    return image != null ? File(image.path) : null;
  }

  Future<File?> takePhoto() async {
    final XFile? photo = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    return photo != null ? File(photo.path) : null;
  }

  Future<XFile?> recordVideo() async {
    return picker.pickVideo(
      source: ImageSource.camera,
      maxDuration: const Duration(seconds: 30),
    );
  }
}
