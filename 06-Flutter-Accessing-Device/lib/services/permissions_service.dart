import 'package:permission_handler/permission_handler.dart';

class PermissionsService {
  static Future<Map<Permission, PermissionStatus>> requestCorePermissions() {
    return [
      Permission.camera,
      Permission.photos,
      Permission.notification,
      Permission.phone,
    ].request();
  }
}
