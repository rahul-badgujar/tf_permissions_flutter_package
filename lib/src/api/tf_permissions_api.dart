import 'package:tf_permissions/src/permissions/tf_always_locations_permission.dart';
import 'package:tf_permissions/src/permissions/tf_camera_permission.dart';
import 'package:tf_permissions/src/permissions/tf_permission_base.dart';
import 'package:tf_permissions/src/permissions/tf_storage_permission.dart';

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
Future<Map<TfPermissionName, bool>> requestPermissions(
    List<TfPermissionName> permissionsNames) async {
  final results = <TfPermissionName, bool>{};
  for (final permissionName in permissionsNames) {
    final permissionInstance = _getPermissionForPermissionName(permissionName);
    final permissionAcceptanceStatus = await permissionInstance.request();
    results[permissionName] = permissionAcceptanceStatus;
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
    default:
      throw UnimplementedError();
  }
}
