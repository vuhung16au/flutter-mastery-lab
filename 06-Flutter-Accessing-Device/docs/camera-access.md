# Camera Access in Flutter

## Overview
This component demonstrates how to access and use the device camera in Flutter applications for taking photos and recording videos.

## Key Components Used

### 1. ImagePicker
- **Purpose**: Provides access to device camera and gallery
- **Usage**: Handles image and video capture functionality

### 2. PermissionHandler
- **Purpose**: Manages device permissions
- **Usage**: Requests and checks camera permissions

### 3. File
- **Purpose**: Represents files on the device
- **Usage**: Stores captured images and videos

### 4. Image
- **Purpose**: Displays images in the UI
- **Usage**: Shows captured photos

## Implementation Steps

1. **Add Dependencies**:
   ```yaml
   dependencies:
     image_picker: ^1.0.0
     permission_handler: ^11.0.0
   ```

2. **Request Camera Permission**:
   ```dart
   Future<void> requestCameraPermission() async {
     final status = await Permission.camera.request();
     if (status.isGranted) {
       // Permission granted, proceed with camera access
     }
   }
   ```

3. **Take Photo from Camera**:
   ```dart
   Future<void> takePhoto() async {
     final ImagePicker picker = ImagePicker();
     final XFile? photo = await picker.pickImage(
       source: ImageSource.camera,
       maxWidth: 1800,
       maxHeight: 1800,
     );
     
     if (photo != null) {
       setState(() {
         _imageFile = File(photo.path);
       });
     }
   }
   ```

4. **Record Video**:
   ```dart
   Future<void> recordVideo() async {
     final ImagePicker picker = ImagePicker();
     final XFile? video = await picker.pickVideo(
       source: ImageSource.camera,
       maxDuration: Duration(seconds: 60),
     );
     
     if (video != null) {
       setState(() {
         _videoFile = File(video.path);
       });
     }
   }
   ```

## Camera Features
- **Photo Capture**: Take high-quality photos
- **Video Recording**: Record videos with duration limits
- **Image Quality Control**: Adjust resolution and compression
- **Gallery Integration**: Save to device gallery
- **Permission Handling**: Proper permission management

## Best Practices
- Always request permissions before camera access
- Handle permission denial gracefully
- Consider image compression for performance
- Test on different devices and orientations
- Provide user feedback during capture
