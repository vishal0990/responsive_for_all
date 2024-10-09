import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

class ImagePickerController extends GetxController {
  // Store selected images for mobile/desktop
  var images = <File>[].obs;

  // Store selected images for web
  var webImages = <XFile>[].obs;

  final ImagePicker _picker = ImagePicker();

  // Method to pick multiple images on mobile
  Future<void> pickImagesMobile() async {
    final pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      images.value = pickedFiles.map((pickedFile) => File(pickedFile.path)).toList();
    }
  }

  // Method to pick images for web/desktop using file_picker
  Future<void> pickImagesWebDesktop() async {
    final pickedFiles = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );

    if (pickedFiles != null && pickedFiles.files.isNotEmpty) {
      if (pickedFiles.files.first.bytes != null) {
        // For web: Add files as XFile
        webImages.value = pickedFiles.files
            .map((file) => XFile.fromData(file.bytes!, name: file.name))
            .toList();
      } else {
        // For desktop: Use file paths
        images.value = pickedFiles.files.map((file) => File(file.path!)).toList();
      }
    }
  }
}
