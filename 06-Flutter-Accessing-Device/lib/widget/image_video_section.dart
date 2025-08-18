import 'dart:io';

import 'package:flutter/material.dart';

class ImageVideoSection extends StatelessWidget {
  final File? selectedImage;
  final VoidCallback onPickFromGallery;
  final VoidCallback onTakePhoto;
  final VoidCallback onRecordVideo;

  const ImageVideoSection({
    super.key,
    required this.selectedImage,
    required this.onPickFromGallery,
    required this.onTakePhoto,
    required this.onRecordVideo,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: onPickFromGallery,
                icon: const Icon(Icons.photo_library),
                label: const Text('Gallery'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: onTakePhoto,
                icon: const Icon(Icons.camera_alt),
                label: const Text('Camera'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ElevatedButton.icon(
          onPressed: onRecordVideo,
          icon: const Icon(Icons.videocam),
          label: const Text('Record Video'),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 48),
          ),
        ),
        if (selectedImage != null) ...[
          const SizedBox(height: 16),
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(selectedImage!, fit: BoxFit.cover),
            ),
          ),
        ],
      ],
    );
  }
}
