// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:image_picker/image_picker.dart';

class ImageData {
  XFile file;
  bool isLocal;
  String? link;
  ImageData({
    required this.file,
    this.link,
    this.isLocal = true,
  });

  @override
  String toString() {
    return file.path;
  }
}
