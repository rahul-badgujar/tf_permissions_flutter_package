import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tf_permissions_flutter_package/bottomsheets.dart';

class TfPermissions{

  final BuildContext context;


  TfPermissions(this.context);

  Future<bool?> checkStoragePermission() async {
    if (await Permission.storage.isGranted ||
        await Permission.storage.isLimited) {
      return true;
    }
    PermissionStatus status = await Permission.storage.request();
    if (status == PermissionStatus.granted ||
        status == PermissionStatus.limited) {
      return true;
    } else if (status == PermissionStatus.permanentlyDenied ||
        status == PermissionStatus.restricted) {
      bool val = (await showConfirmationBottomSheet(context,
          title: "Permission Required",
          desc: "To use this feature, you need to allow storage permissions",
          negative: "Cancel",
          positive: "Allow",
          isDismissible: false)) ??
          false;

      if (!val) {
        return false;
      }
      await AppSettings.openAppSettings(asAnotherTask: true);
      return false;
    } else if (status == PermissionStatus.denied) {
      bool val = (await showConfirmationBottomSheet(context,
          title: "Permission Required",
          desc: "To use this feature, you need to allow storage permissions",
          negative: "Cancel",
          positive: "Allow",
          isDismissible: false)) ??
          false;

      if (!val) {
        return false;
      }
      return await checkStoragePermission();
    }
    return null;
  }

  Future<bool?> checkLocationPermission() async {
    PermissionStatus status = await Permission.location.request();
    if (status == PermissionStatus.granted ||
        status == PermissionStatus.limited) {
      return true;
    } else if (status == PermissionStatus.permanentlyDenied ||
        status == PermissionStatus.restricted) {
      bool val = (await showConfirmationBottomSheet(context,
          title: "Permission Required",
          desc:
          "To run Comped smoothly, it requires location permissions , If you have already granted the permissions previously , Please make sure to enable location services",
          negative: "Cancel",
          positive: "Allow",
          isDismissible: false)) ??
          false;

      if (!val) {
        return false;
      }
      await AppSettings.openAppSettings(asAnotherTask: true);
      return false;
    } else if (status == PermissionStatus.denied) {
      bool val = (await showConfirmationBottomSheet(context,
          title: "Permission Required",
          desc:
          "To run Comped smoothly, it requires location permissions , If you have already granted the permissions previously , Please make sure to enable location services",
          negative: "Cancel",
          positive: "Allow",
          isDismissible: false)) ??
          false;

      if (!val) {
        return false;
      }
      return await checkLocationPermission();
    }
    return null;
  }

  Future<bool?> checkCameraPermission() async {
    PermissionStatus status = await Permission.camera.request();
    if (status == PermissionStatus.granted ||
        status == PermissionStatus.limited) {
      return true;
    } else if (status == PermissionStatus.permanentlyDenied ||
        status == PermissionStatus.restricted) {
      bool val = (await showConfirmationBottomSheet(context,
          title: "Permission Required",
          desc: "To use this feature, you need to allow camera permissions",
          negative: "Cancel",
          positive: "Allow",
          isDismissible: false)) ??
          false;

      if (!val) {
        return false;
      }
      await AppSettings.openAppSettings(asAnotherTask: true);
      return false;
    } else if (status == PermissionStatus.denied) {
      bool val = (await showConfirmationBottomSheet(context,
          title: "Permission Required",
          desc: "To use this feature, you need to allow camera permissions",
          negative: "Cancel",
          positive: "Allow",
          isDismissible: false)) ??
          false;
      if (!val) {
        return false;
      }

      return await checkCameraPermission();
    }
    return null;
  }
}