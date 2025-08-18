import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'dart:io';
import 'dart:async';
import '../services/notification_service.dart';
import '../services/permissions_service.dart';
import '../services/media_service.dart';
import '../services/device_actions.dart';
import '../widget/section_card.dart';
import '../widget/image_video_section.dart';
import '../widget/system_controls_section.dart';
import '../widget/notifications_section.dart';
import '../widget/communication_section.dart';
import '../widget/fab_speed_dial.dart';
import '../widget/device_info_card.dart';

class DeviceAccessHomePage extends StatefulWidget {
  const DeviceAccessHomePage({super.key});
  @override
  State<DeviceAccessHomePage> createState() => _DeviceAccessHomePageState();
}

class _DeviceAccessHomePageState extends State<DeviceAccessHomePage> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  late final MediaService _mediaService;
  bool _isPortraitOnly = true;
  bool _isWakelockEnabled = false;

  @override
  void initState() {
    super.initState();
    _mediaService = MediaService(picker: _picker);
    _checkPermissions();
    _checkWakelockStatus();
  }

  Future<void> _checkPermissions() async {
    final statuses = await PermissionsService.requestCorePermissions();
    debugPrint('Permission statuses: $statuses');
  }

  Future<void> _checkWakelockStatus() async {
    try {
      final status = await WakelockPlus.enabled;
      setState(() => _isWakelockEnabled = status);
    } catch (e) {
      debugPrint('Error checking wakelock status: $e');
    }
  }

  Future<void> _pickImageFromGallery() async {
    try {
      final picked = await _mediaService.pickImageFromGallery();
      if (picked != null) setState(() => _selectedImage = picked);
    } catch (e) {
      _showSnackBar('Error picking image: $e');
    }
  }

  Future<void> _takePhotoWithCamera() async {
    try {
      final photo = await _mediaService.takePhoto();
      if (photo != null) setState(() => _selectedImage = photo);
    } catch (e) {
      _showSnackBar('Error taking photo: $e');
    }
  }

  Future<void> _recordVideo() async {
    try {
      final video = await _mediaService.recordVideo();
      if (video != null) _showSnackBar('Video recorded: ${video.path}');
    } catch (e) {
      _showSnackBar('Error recording video: $e');
    }
  }

  void _toggleOrientation() async {
    if (_isPortraitOnly) {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      setState(() => _isPortraitOnly = false);
      _showSnackBar('All orientations enabled');
    } else {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
      setState(() => _isPortraitOnly = true);
      _showSnackBar('Portrait mode only');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _sendEmail() => DeviceActions.sendEmail(context);
  Future<void> _makePhoneCall() => DeviceActions.makePhoneCall(context);
  Future<void> _openWebsite() => DeviceActions.openWebsite(context);

  Future<void> _toggleWakelock() async {
    final next = !_isWakelockEnabled;
    final result = await DeviceActions.setWakelockEnabled(next);
    if (!mounted) return;
    setState(() => _isWakelockEnabled = result);
    _showSnackBar(result ? 'Wakelock enabled' : 'Wakelock disabled');
  }

  Future<void> _makeHttpRequest() => DeviceActions.makeHttpRequest(context);

  Future<void> _showNotification() async {
    try {
      await NotificationService.showNotification(
        title: 'Device Access Demo',
        body: 'This is a test notification from the Flutter app!',
      );
      _showSnackBar('Notification sent');
    } catch (e) {
      _showSnackBar('Error showing notification: $e');
    }
  }

  Future<void> _scheduleNotification() async {
    try {
      await NotificationService.scheduleNotification(
        title: 'Scheduled Notification',
        body: 'This notification was scheduled 5 seconds ago!',
        delay: const Duration(seconds: 5),
      );
      _showSnackBar('Notification scheduled for 5 seconds');
    } catch (e) {
      _showSnackBar('Error scheduling notification: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Device Access Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SectionCard(title: 'Device Information', children: [DeviceInfoCard()]),
            const SizedBox(height: 16),
            SectionCard(
              title: 'Image & Video',
              children: [
                ImageVideoSection(
                  selectedImage: _selectedImage,
                  onPickFromGallery: _pickImageFromGallery,
                  onTakePhoto: _takePhotoWithCamera,
                  onRecordVideo: _recordVideo,
                ),
              ],
            ),
            const SizedBox(height: 16),
            SectionCard(
              title: 'System Controls',
              children: [
                SystemControlsSection(
                  isPortraitOnly: _isPortraitOnly,
                  isWakelockEnabled: _isWakelockEnabled,
                  onToggleOrientation: _toggleOrientation,
                  onToggleWakelock: _toggleWakelock,
                ),
              ],
            ),
            const SizedBox(height: 16),
            SectionCard(
              title: 'Notifications',
              children: [
                NotificationsSection(
                  onShowNow: _showNotification,
                  onSchedule: _scheduleNotification,
                ),
              ],
            ),
            const SizedBox(height: 16),
            SectionCard(
              title: 'Communication',
              children: [
                CommunicationSection(
                  onEmail: _sendEmail,
                  onCall: _makePhoneCall,
                  onOpenWebsite: _openWebsite,
                ),
              ],
            ),
            const SizedBox(height: 16),
            SectionCard(
              title: 'Network',
              children: [
                ElevatedButton.icon(
                  onPressed: _makeHttpRequest,
                  icon: const Icon(Icons.http),
                  label: const Text('Make HTTP Request'),
                  style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48)),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: DeviceAccessFab(
        onEmail: _sendEmail,
        onCall: _makePhoneCall,
        onNotify: _showNotification,
      ),
    );
  }
}
