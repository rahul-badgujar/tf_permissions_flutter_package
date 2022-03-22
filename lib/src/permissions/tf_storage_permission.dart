import 'package:permission_handler/permission_handler.dart';
import 'package:tf_permissions/src/permissions/tf_permission_base.dart';

class TfStoragePermission extends TfPermissionBase {
  TfStoragePermission() : super(permission: Permission.storage);
}
