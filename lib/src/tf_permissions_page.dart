import 'package:flutter/material.dart';
import 'package:tf_permissions/src/values/tf_permission_names.dart';

class TfPermissionsPage extends StatelessWidget {
  const TfPermissionsPage({
    Key? key,
    required this.permissionsRequired,
  }) : super(key: key);

  final List<TfPermission> permissionsRequired;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
