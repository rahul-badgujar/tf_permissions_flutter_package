import 'package:app_settings/app_settings.dart';

abstract class TfPermissionBase {
  Future<bool> check() async {
    if (await isGranted() && await isLimited()) {
      return true;
    }
    return false;
  }

  Future<bool> isLimited();
  Future<bool> isGranted();
  Future<bool> isPermanentlyDenied();
  Future<bool> isRestricted();
  Future<bool> isDenied();
  //
  Future<void> request();

  Future<void> openSettings() async {
    await AppSettings.openAppSettings(asAnotherTask: true);
  }
}
