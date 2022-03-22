import 'package:permission_handler/permission_handler.dart';
import 'package:tf_permissions/src/permissions/tf_permission_base.dart';

/// Represents Location-Always-Allow Permission.
class TfLocationAlwaysPermission extends TfPermissionBase {
  TfLocationAlwaysPermission() : super(permission: Permission.locationAlways);
}
