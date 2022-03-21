import 'package:permission_handler/permission_handler.dart';
import 'package:tf_permissions/src/permissions/tf_permission_base.dart';

class TfStoragePermission extends TfPermissionBase{
  @override
  Future<bool> isGranted() async {
    return await Permission.storage.isGranted;
  }

  @override
  Future<bool> isLimited() async {
    return await Permission.storage.isLimited;
  }

  @override
  Future<bool> isPermanentlyDenied() async {
    return await Permission.storage.isPermanentlyDenied;
  }

  @override
  Future<bool> isRestricted() async {
    return await Permission.storage.isRestricted;
  }

  @override
  Future<bool> isDenied() async {
    return await Permission.storage.isDenied;
  }

  @override
  void request() async {
    if(await isPermanentlyDenied() || await isRestricted()){
      await openSettings();
    }else if(await isDenied()){
      await Permission.storage.request();
    }
  }



}