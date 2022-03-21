import 'package:permission_handler/permission_handler.dart';
import 'package:tf_permissions/src/permissions/tf_permission_base.dart';

class TfAlwaysLocationPermission extends TfPermissionBase{
  @override
  Future<bool> isGranted() async {
    return await Permission.locationAlways.isGranted;
  }

  @override
  Future<bool> isLimited() async {
    return await Permission.locationAlways.isLimited;
  }

  @override
  Future<bool> isPermanentlyDenied() async {
    return await Permission.locationAlways.isPermanentlyDenied;
  }

  @override
  Future<bool> isRestricted() async {
    return await Permission.locationAlways.isRestricted;
  }

  @override
  Future<bool> isDenied() async {
    return await Permission.locationAlways.isDenied;
  }

  @override
  void request() async {
    if(await isPermanentlyDenied() || await isRestricted()){
      await openSettings();
    }else if(await isDenied()){
      await Permission.locationAlways.request();
    }
  }



}