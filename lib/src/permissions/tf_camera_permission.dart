import 'package:permission_handler/permission_handler.dart';
import 'package:tf_permissions/src/permissions/tf_permission_base.dart';

/// Represents Camera Permission.
class TfCameraPermission extends TfPermissionBase {
  TfCameraPermission() : super(permission: Permission.camera);
}
