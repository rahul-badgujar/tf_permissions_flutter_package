import 'package:flutter/material.dart';

import '../../tf_permissions.dart';
import '../api/tf_permissions_api.dart';

class TfPermissionsRequester extends StatefulWidget {
  const TfPermissionsRequester({
    Key? key,
    required this.permissionsRequired,
    this.attempts = 5,
    required this.onAcceptedAllPermissions,
    required this.onExceededAttempts,
  }) : super(key: key);

  final List<TfPermissionName> permissionsRequired;
  final int attempts;
  final Function onAcceptedAllPermissions;
  final Function onExceededAttempts;

  @override
  State<TfPermissionsRequester> createState() => _TfPermissionsRequesterState();
}

class _TfPermissionsRequesterState extends State<TfPermissionsRequester>
    with WidgetsBindingObserver {
  bool doReload = false;
  int attemptCounter = 0;
  static const int PERMISSIONS_ACCEPTED_ALL = 1;
  static const int PERMISSIONS_RESTRICTED_SOME = 0;
  static const int PERMISSIONS_REQUEST_LIMIT_OUT = -1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      doReload = true;
    }
    if (state == AppLifecycleState.resumed && doReload) {
      doReload = false;
      askForPermissions().then(_handlePermissionsAcceptanceResult);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        askForPermissions().then(_handlePermissionsAcceptanceResult);
        return const SizedBox();
      },
    );
  }

  void _handlePermissionsAcceptanceResult(int status) {
    if (status == PERMISSIONS_ACCEPTED_ALL) {
      widget.onAcceptedAllPermissions.call();
    } else if (status == PERMISSIONS_REQUEST_LIMIT_OUT) {
      widget.onExceededAttempts.call();
    }
  }

  Future<int> askForPermissions() async {
    // CASE: user has exceeded the limit of chances to accept requests
    if (attemptCounter >= widget.attempts) {
      return PERMISSIONS_REQUEST_LIMIT_OUT;
    }
    final result =
        await requestPermissions(permissionsNames: widget.permissionsRequired);
    // CASE: if any permission is Permanently Denied or Restricted (Setting Page was opened)
    // Continue this attempt
    if (result.containsValue(TfPermissionStatus.permanentlyDenied) ||
        result.containsValue(TfPermissionStatus.restricted)) {
      return PERMISSIONS_RESTRICTED_SOME;
    }
    // CASE: If not all permissions are accepted, some are denied
    // Go for next attempt
    else if (result.containsValue(TfPermissionStatus.denied)) {
      attemptCounter++;
      // Recur for next attempt
      return await askForPermissions();
    }
    // CASE: all permissions are accepted
    return PERMISSIONS_ACCEPTED_ALL;
  }
}
