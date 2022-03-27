import 'package:tf_permissions/src/permissions/tf_permissions_impl.dart';
import 'package:tf_permissions/src/values/tf_permission_status.dart';

import '../values/tf_permission_names.dart';

/// Request a list of permissions from OS.
///
/// [permissionNames]: List of permissions to be requested. \
/// Returns: A result in form of TfPermissionName mapped to status of permission grant for all [permissionNames].
///
/// Throws: UnimplementedError if implementation is not added for any of required permissions.
///
/// NOTE: If the user has Permanently Denied or Restricted the Permission,
/// User will be promoted with App Settings (or App Info) Page to allow the permission.
Future<Map<TfPermissionName, TfPermissionStatus>> requestPermissions(
    {required List<TfPermissionName> permissionsNames}) async {
  final results = <TfPermissionName, TfPermissionStatus>{};
  for (final permissionName in permissionsNames) {
    final permissionInstance = _getPermissionForPermissionName(permissionName);
    final permissionAcceptanceStatus = await permissionInstance.request();
    results[permissionName] = permissionAcceptanceStatus;
    if(permissionAcceptanceStatus == TfPermissionStatus.permanentlyDenied || permissionAcceptanceStatus == TfPermissionStatus.restricted){
      break;
    }
  }
  return results;
}

/// Get instance of Permission for given [permissionName].
///
/// Throws: UnimplementedError if implementation for given [permissionName] is not added yet.
TfPermissionBase _getPermissionForPermissionName(
    TfPermissionName permissionName) {
  switch (permissionName) {
    case TfPermissionName.camera:
      return TfCameraPermission();
    case TfPermissionName.storage:
      return TfStoragePermission();
    case TfPermissionName.locationAlways:
      return TfLocationAlwaysPermission();
    case TfPermissionName.location:
      return TfLocationPermission();
    default:
      throw UnimplementedError();
  }
}
