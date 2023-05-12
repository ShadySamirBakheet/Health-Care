// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:image_picker/image_picker.dart';

class ImageData {
  XFile file;
  bool isLocal;
  ImageData({
    required this.file,
    this.isLocal = true,
  });

  @override
  String toString() {
    return file.path;
  }
}
