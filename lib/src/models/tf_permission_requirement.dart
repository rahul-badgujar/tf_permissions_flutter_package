import 'package:tf_permissions/src/values/tf_permission_names.dart';

/// Represents the requirement of a permission.
class TfPermissionRequirement {
  final TfPermissionName permission;
  final String whyRequirePermission;
  final bool mustAccept;
  final bool isLimited;

  TfPermissionRequirement({
    required this.permission,
    required this.whyRequirePermission,
    this.mustAccept = true,
    this.isLimited = false,
  });
}
