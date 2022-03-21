import 'package:flutter/material.dart';
import 'package:tf_permissions/src/models/tf_permission_requirement.dart';

class TfPermissionsPage extends StatelessWidget {
  const TfPermissionsPage({
    Key? key,
    required this.permissionsRequired,
  }) : super(key: key);

  final List<TfPermissionRequirement> permissionsRequired;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
