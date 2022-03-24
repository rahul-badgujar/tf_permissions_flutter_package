
import 'package:app_settings/app_settings.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tf_permissions/src/values/tf_permission_status.dart';

/// Base class representing a permission.
abstract class TfPermissionBase {
  TfPermissionBase({required this.permission});

  /// The underlying permission instance.
  final Permission permission;

  /// Returns `true` if Permission is granted, otherwise returns `false`.
  Future<TfPermissionStatus> check() async {
    final status = await permission.status;
    final tfStatus = getTfPermissionStatusFromPermissionStatus(status);
    return tfStatus;
  }

  /// Request for Permission. \
  /// Returns `true` if permission is granted, otherwise returns `false`.
  ///
  /// NOTE: If the user has Permanently Denied or Restricted the Permission,
  /// User will be promoted with App Settings (or App Info) Page to allow the permission.
  Future<TfPermissionStatus> request() async {
    // CASE: Permission is already granted.
    final initialStatus = await check();
    if (initialStatus == TfPermissionStatus.granted ||
        initialStatus == TfPermissionStatus.limited) {
      return initialStatus;
    }

    // CASE: Permission is restricted by user by purpose.
    final shouldPromptSettings =
        (await isPermanentlyDenied()) || (await isRestricted());

    if (shouldPromptSettings) {
      await openSettings();
      return TfPermissionStatus.permanentlyDenied;
    } else if (await isDenied()) {
      // CASE: Permission is just denied.
      PermissionStatus status = await permission.request();
      if(status == PermissionStatus.permanentlyDenied){
        await openSettings();
        return TfPermissionStatus.permanentlyDenied;
      }
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
