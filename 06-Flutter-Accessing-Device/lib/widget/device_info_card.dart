import 'package:flutter/material.dart';
import '../services/device_info_service.dart';

class DeviceInfoCard extends StatefulWidget {
  const DeviceInfoCard({super.key});

  @override
  State<DeviceInfoCard> createState() => _DeviceInfoCardState();
}

class _DeviceInfoCardState extends State<DeviceInfoCard> {
  String _info = 'Loading device info...';

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final summary = await DeviceInfoService.loadSummary();
    if (!mounted) return;
    setState(() {
      _info = summary.toDisplayString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(_info);
  }
}


