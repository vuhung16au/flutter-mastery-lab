# Flutter - Accessing Device

## Overview

This project explores how Flutter enables developers to access device features such as cameras, sensors, and storage. Flutter provides plugins that allow easy integration with device hardware and APIs, making it straightforward to utilize functionalities like taking pictures, accessing location data, or storing files locally.

## Components

### Device Access Components
1. **Gallery Access in Flutter** - Access and manage device photo gallery
2. **Camera Access in Flutter** - Use device camera for taking photos and videos
3. **Background local notifications in Flutter** - Send and manage local notifications
4. **Restrict Landscape Mode in Flutter** - Control device orientation

## Getting Started

1. Navigate to the project directory
2. Run `flutter pub get` to install dependencies
3. Run `flutter run` to start the application

## Dependencies

This project uses various Flutter packages for device access:
- `image_picker` for camera and gallery access
- `permission_handler` for managing permissions
- `flutter_local_notifications` for local notifications
- `device_info_plus` for device information
- `flutter/services.dart` for screen orientation control

## Key Features

### Camera & Gallery
- Take photos using device camera
- Select images from gallery
- Record videos
- Image compression and processing

### Notifications
- Local notification scheduling
- Background notification handling
- Custom notification sounds
- Notification actions

### Device Control
- Screen orientation management
- Device information access
- Permission handling
- Hardware feature detection

## Permissions Required

### Android
- `android.permission.CAMERA`
- `android.permission.READ_EXTERNAL_STORAGE`
- `android.permission.WRITE_EXTERNAL_STORAGE`
- `android.permission.RECEIVE_BOOT_COMPLETED`

### iOS
- `NSCameraUsageDescription`
- `NSPhotoLibraryUsageDescription`
- `NSPhotoLibraryAddUsageDescription`
