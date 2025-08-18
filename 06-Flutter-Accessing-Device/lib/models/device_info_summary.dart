import 'dart:io';

/// Simple model representing the most relevant device info to render in UI.
class DeviceInfoSummary {
  final String platformLabel; // e.g., Android/iOS
  final String osVersion; // e.g., 14 / 18.4
  final String model; // e.g., Pixel 9a
  final String brandOrName; // e.g., Google / iPhone name

  const DeviceInfoSummary({
    required this.platformLabel,
    required this.osVersion,
    required this.model,
    required this.brandOrName,
  });

  factory DeviceInfoSummary.unknown() => const DeviceInfoSummary(
    platformLabel: 'Unknown',
    osVersion: '-',
    model: '-',
    brandOrName: '-',
  );

  String toDisplayString() {
    final platformPrefix = Platform.isAndroid
        ? 'Android'
        : Platform.isIOS
        ? 'iOS'
        : platformLabel;
    return '$platformPrefix $osVersion\nModel: $model\nBrand/Name: $brandOrName';
  }
}
