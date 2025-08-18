import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class DeviceAccessFab extends StatelessWidget {
  final VoidCallback onEmail;
  final VoidCallback onCall;
  final VoidCallback onNotify;

  const DeviceAccessFab({
    super.key,
    required this.onEmail,
    required this.onCall,
    required this.onNotify,
  });

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      icon: Icons.add,
      activeIcon: Icons.close,
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      activeBackgroundColor: Colors.red,
      activeForegroundColor: Colors.white,
      buttonSize: const Size(56.0, 56.0),
      visible: true,
      closeManually: false,
      curve: Curves.bounceIn,
      overlayColor: Colors.black,
      overlayOpacity: 0.5,
      elevation: 8.0,
      shape: const CircleBorder(),
      children: [
        SpeedDialChild(
          child: const Icon(Icons.email),
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          label: 'Email',
          onTap: onEmail,
        ),
        SpeedDialChild(
          child: const Icon(Icons.phone),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          label: 'Call',
          onTap: onCall,
        ),
        SpeedDialChild(
          child: const Icon(Icons.notifications),
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
          label: 'Notification',
          onTap: onNotify,
        ),
      ],
    );
  }
}
