import 'package:app_settings/app_settings.dart';
import 'package:permission_handler/permission_handler.dart';

/// Base class representing a permission.
abstract class TfPermissionBase {
  TfPermissionBase({required this.permission});

  /// The underlying permission instance.
  final Permission permission;

  /// Returns `true` if Permission is granted, otherwise returns `false`.
  Future<bool> check() async {
    if (await isGranted() && await isLimited()) {
      return true;
    }
    return false;
  }

  /// Request for Permission. \
  /// Returns `true` if permission is granted, otherwise returns `false`.
  ///
  /// NOTE: If the user has Permanently Denied or Restricted the Permission,
  /// User will be promoted with App Settings (or App Info) Page to allow the permission.
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

  /// Opens the App Setting or App Info Page provided by Operating System.
  Future<void> openSettings() async {
    await AppSettings.openAppSettings(asAnotherTask: true);
  }

  /// Returns  `true` if Permission is Limited, otherwise returns `false`.
  Future<bool> isLimited() async {
    return (await permission.isLimited);
  }

  /// Returns  `true` if Permission is Granted by User, otherwise returns `false`.
  Future<bool> isGranted() async {
    return (await permission.isGranted);
  }

  /// Returns  `true` if Permission is Permanently Denied by User, otherwise returns `false`.
  Future<bool> isPermanentlyDenied() async {
    return (await permission.isPermanentlyDenied);
  }

  /// Returns  `true` if Permission is Restricted by User, otherwise returns `false`.
  Future<bool> isRestricted() async {
    return (await permission.isRestricted);
  }

  /// Returns  `true` if Permission is  Denied by User, otherwise returns `false`.
  Future<bool> isDenied() async {
    return (await permission.isDenied);
  }
}

/// Represents Camera Permission.
class TfCameraPermission extends TfPermissionBase {
  TfCameraPermission() : super(permission: Permission.camera);
}

/// Represents Storage Permission.
class TfStoragePermission extends TfPermissionBase {
  TfStoragePermission() : super(permission: Permission.storage);
}

/// Represents Location-Always-Allow Permission.
class TfLocationAlwaysPermission extends TfPermissionBase {
  TfLocationAlwaysPermission() : super(permission: Permission.locationAlways);
}
