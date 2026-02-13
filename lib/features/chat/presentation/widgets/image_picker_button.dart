import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nonstop/core/theme/app_colors.dart';
import 'package:nonstop/core/theme/app_typography.dart';
import 'package:nonstop/core/extensions/context_extensions.dart';

class ImagePickerButton extends StatelessWidget {
  final Function(File imageFile) onImageSelected;

  const ImagePickerButton({
    super.key,
    required this.onImageSelected,
  });

  Future<void> _showPicker(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt, color: AppColors.primary),
              title: Text('카메라', style: AppTypography.body1),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library, color: AppColors.primary),
              title: Text('갤러리', style: AppTypography.body1),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: source,
      maxWidth: 1080,
      maxHeight: 1080,
      imageQuality: 85,
    );

    if (pickedFile != null) {
      onImageSelected(File(pickedFile.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _showPicker(context),
      icon: const Icon(Icons.camera_alt_outlined),
      color: context.textSecondaryColor,
      tooltip: '이미지 첨부',
    );
  }
}
