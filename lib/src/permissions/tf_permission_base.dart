import 'package:app_settings/app_settings.dart';

abstract class TfPermissionBase {
  bool check() {
    if (isGranted() && isLimited()) {
      return true;
    }
    return false;
  }

  bool isLimited();
  bool isGranted();
  bool isPermanentlyDenied();
  bool isRestricted();
  //
  void request();

  Future<void> _openSettings() async {
    await AppSettings.openAppSettings(asAnotherTask: true);
  }
}
