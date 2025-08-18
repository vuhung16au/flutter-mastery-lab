# Gallery Access in Flutter

## Overview

Gallery access in Flutter allows your app to select images and videos from the device's photo gallery. This is essential for apps that need to work with user media, such as social media apps, photo editors, or profile picture selectors.

## Implementation

### 1. Dependencies

Add the required dependencies to your `pubspec.yaml`:

```yaml
dependencies:
  image_picker: ^1.0.7
  permission_handler: ^11.3.1
```

### 2. Permissions Setup

#### Android Permissions

Add the following permissions to `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
```

For Android 13+ (API level 33+), also add:

```xml
<uses-permission android:name="android.permission.READ_MEDIA_IMAGES" />
<uses-permission android:name="android.permission.READ_MEDIA_VIDEO" />
```

#### iOS Permissions

Add the following keys to `ios/Runner/Info.plist`:

```xml
<key>NSPhotoLibraryUsageDescription</key>
<string>This app needs access to photo library to select images.</string>
<key>NSPhotoLibraryAddUsageDescription</key>
<string>This app needs access to photo library to save images.</string>
```

### 3. Code Implementation

```dart
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class GalleryAccessExample {
  final ImagePicker _picker = ImagePicker();

  // Request permissions
  Future<bool> _requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.photos,
    ].request();
    
    return statuses[Permission.photos]!.isGranted;
  }

  // Pick image from gallery
  Future<File?> pickImageFromGallery() async {
    try {
      // Check permissions first
      bool hasPermission = await _requestPermissions();
      if (!hasPermission) {
        throw Exception('Gallery permission denied');
      }

      // Pick image from gallery
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 85,
      );

      if (image != null) {
        return File(image.path);
      }
      return null;
    } catch (e) {
      print('Error picking image: $e');
      return null;
    }
  }

  // Pick video from gallery
  Future<File?> pickVideoFromGallery() async {
    try {
      bool hasPermission = await _requestPermissions();
      if (!hasPermission) {
        throw Exception('Gallery permission denied');
      }

      final XFile? video = await _picker.pickVideo(
        source: ImageSource.gallery,
        maxDuration: const Duration(minutes: 10),
      );

      if (video != null) {
        return File(video.path);
      }
      return null;
    } catch (e) {
      print('Error picking video: $e');
      return null;
    }
  }

  // Pick multiple images
  Future<List<File>> pickMultipleImages() async {
    try {
      bool hasPermission = await _requestPermissions();
      if (!hasPermission) {
        throw Exception('Gallery permission denied');
      }

      final List<XFile> images = await _picker.pickMultiImage(
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 85,
      );

      return images.map((xFile) => File(xFile.path)).toList();
    } catch (e) {
      print('Error picking multiple images: $e');
      return [];
    }
  }
}
```

### 4. UI Implementation

```dart
class GalleryAccessWidget extends StatefulWidget {
  @override
  _GalleryAccessWidgetState createState() => _GalleryAccessWidgetState();
}

class _GalleryAccessWidgetState extends State<GalleryAccessWidget> {
  File? _selectedImage;
  final GalleryAccessExample _galleryAccess = GalleryAccessExample();

  Future<void> _pickImage() async {
    final File? image = await _galleryAccess.pickImageFromGallery();
    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: _pickImage,
          icon: Icon(Icons.photo_library),
          label: Text('Select from Gallery'),
        ),
        if (_selectedImage != null) ...[
          SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.file(
              _selectedImage!,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ],
    );
  }
}
```

## Advanced Features

### 1. Image Compression

```dart
Future<File?> pickCompressedImage() async {
  final XFile? image = await _picker.pickImage(
    source: ImageSource.gallery,
    maxWidth: 1024,  // Compress to max 1024px width
    maxHeight: 1024, // Compress to max 1024px height
    imageQuality: 70, // Reduce quality to 70%
  );
  
  if (image != null) {
    return File(image.path);
  }
  return null;
}
```

### 2. Custom Image Cropping

```dart
Future<File?> pickAndCropImage() async {
  final XFile? image = await _picker.pickImage(
    source: ImageSource.gallery,
    cropStyle: CropStyle.rectangle, // Enable cropping
  );
  
  if (image != null) {
    return File(image.path);
  }
  return null;
}
```

### 3. Video Selection with Duration Limit

```dart
Future<File?> pickVideoWithDurationLimit() async {
  final XFile? video = await _picker.pickVideo(
    source: ImageSource.gallery,
    maxDuration: Duration(minutes: 5), // Max 5 minutes
  );
  
  if (video != null) {
    return File(video.path);
  }
  return null;
}
```

## Best Practices

### 1. Permission Handling

- Always check permissions before accessing the gallery
- Provide clear explanations for why permissions are needed
- Handle permission denial gracefully
- Consider implementing a permission request flow

### 2. Performance Optimization

- Compress images to reduce memory usage
- Use appropriate image quality settings
- Consider lazy loading for multiple images
- Implement proper error handling

### 3. User Experience

- Show loading indicators during image selection
- Provide clear feedback for successful/failed operations
- Implement image preview functionality
- Consider implementing image editing features

### 4. Error Handling

```dart
Future<File?> pickImageWithErrorHandling() async {
  try {
    bool hasPermission = await _requestPermissions();
    if (!hasPermission) {
      // Show permission denied dialog
      _showPermissionDeniedDialog();
      return null;
    }

    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {
      return File(image.path);
    }
    return null;
  } catch (e) {
    // Show error dialog
    _showErrorDialog('Failed to pick image: $e');
    return null;
  }
}
```

## Troubleshooting

### Common Issues

1. **Permission Denied**: Ensure proper permission setup in manifest files
2. **Image Not Loading**: Check file path and permissions
3. **App Crashes**: Implement proper error handling and null checks
4. **Performance Issues**: Use image compression and lazy loading

### Debug Tips

- Use `print` statements to debug permission status
- Check device logs for permission-related errors
- Test on different Android/iOS versions
- Verify manifest file configurations

## Platform-Specific Considerations

### Android

- Different permission models for different API levels
- Storage access framework for Android 10+
- Scoped storage considerations

### iOS

- Photo library access requires user consent
- Limited access to photo library in iOS 14+
- Privacy-focused permission model

## Conclusion

Gallery access is a fundamental feature for many Flutter apps. By following these guidelines and best practices, you can implement robust gallery access functionality that works reliably across different platforms and provides a great user experience.
