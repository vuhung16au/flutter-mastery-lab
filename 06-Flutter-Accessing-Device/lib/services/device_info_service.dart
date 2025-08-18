import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import '../models/device_info_summary.dart';

class DeviceInfoService {
  static Future<DeviceInfoSummary> loadSummary() async {
    try {
      final deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        return DeviceInfoSummary(
          platformLabel: 'Android',
          osVersion: androidInfo.version.release,
          model: androidInfo.model,
          brandOrName: androidInfo.brand,
        );
      }
      if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        return DeviceInfoSummary(
          platformLabel: 'iOS',
          osVersion: iosInfo.systemVersion,
          model: iosInfo.model,
          brandOrName: iosInfo.name,
        );
      }
      return DeviceInfoSummary.unknown();
    } catch (_) {
      return DeviceInfoSummary.unknown();
    }
  }
}
