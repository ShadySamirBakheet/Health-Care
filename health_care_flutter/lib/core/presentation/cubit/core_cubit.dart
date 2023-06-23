import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care_flutter/core/domain/entities/image_type.dart';
import 'package:image_picker/image_picker.dart';

part 'core_state.dart';

class PasswordManageCubit extends Cubit<PasswordManageState> {
  PasswordManageCubit() : super(PasswordManageInitial());
  static PasswordManageCubit cubit(BuildContext context) =>
      BlocProvider.of(context);

  bool isVisible = true;

  void changeVisibility({required bool isVisible}) {
    this.isVisible = isVisible;
    emit(state);
  }
}

class ImagePickerCubit extends Cubit<ImagePickerState> {
  ImagePickerCubit(
    super.initialState, {
    required this.images,
    this.onChanged,
    this.onDelete,
  });

  final ImagePicker picker = ImagePicker();
  final void Function(List<ImageData>?)? onChanged;
  final void Function(ImageData)? onDelete;

  static ImagePickerCubit cubit(BuildContext context) =>
      BlocProvider.of(context);
  final List<ImageData> images;
  Future pickImage({ImageSource source = ImageSource.gallery}) async {
    final image = await picker.pickImage(source: source);
    if (image != null) {
      images.add(
        ImageData(
          file: image,
        ),
      );
      onChanged?.call(images);
      emit(ImagePickerAddImage());
    }
  }

  void deleteImage(ImageData imageData) {
    onDelete?.call(imageData);
    images.remove(imageData);
    emit(ImagePickerAddImage());
  }
}
