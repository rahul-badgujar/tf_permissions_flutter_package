import 'package:app_settings/app_settings.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class TfPermissionBase {
  final Permission permission;

  TfPermissionBase({required this.permission});

  Future<bool> check() async {
    if (await isGranted() && await isLimited()) {
      return true;
    }
    return false;
  }

  Future<bool> isLimited() async {
    return (await permission.isLimited);
  }

  Future<bool> isGranted() async {
    return (await permission.isGranted);
  }

  Future<bool> isPermanentlyDenied() async {
    return (await permission.isPermanentlyDenied);
  }

  Future<bool> isRestricted() async {
    return (await permission.isRestricted);
  }

  Future<bool> isDenied() async {
    return (await permission.isDenied);
  }

  Future<bool> request() async {
    // CASE: Permission is already granted.
    final isAlreadyGiven = await check();
    if (isAlreadyGiven) return true;

    // CASE: Permission is restricted by user by purpose.
    final shouldPromptSettings =
        (await isPermanentlyDenied()) || (await isRestricted());
    if (shouldPromptSettings) {
      await openSettings();
    } else if (await isDenied()) {
      // CASE: Permission is just denied.
      await permission.request();
    }

    // Return final status of permission status.
    return await check();
  }

  Future<void> openSettings() async {
    await AppSettings.openAppSettings(asAnotherTask: true);
  }
}
