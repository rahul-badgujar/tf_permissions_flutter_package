// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import '../../tf_permissions.dart';
import '../api/tf_permissions_api.dart';

class TfPermissionsRequester extends StatefulWidget {
  ///
  /// Widget to request user for all permissions required for your app.
  ///
  /// [permissionsRequired]: List of TfPermissionName you want to request. \
  /// [attempts]: Maximum attempts for user to accept all requests. Defaults to 5. \
  /// [onAcceptedAllPermissions]: Callback to execute when all permissions are accepted by user. \
  /// [onExceededAttempts]: Callback to execute when user has excedeed maximum limits of attempts to accept requests. \
  ///
  /// Throws: UnimplementedError if implementation is not added for any of required permissions.
  ///
  /// NOTE: If the user has Permanently Denied or Restricted the Permission,
  /// User will be promoted with App Settings (or App Info) Page to allow the permission.
  /// This is not counted as a valid attempt. So user will be kept showing settings page if he keeps permanently denying permissions.
  ///
  const TfPermissionsRequester({
    Key? key,
    required this.permissionsRequired,
    this.attempts = 5,
    required this.onAcceptedAllPermissions,
    required this.onExceededAttempts,
  }) : super(key: key);

  /// List of TfPermissionName you want to request.
  final List<TfPermissionName> permissionsRequired;

  /// Maximum attempts for user to accept all requests. Defaults to 5.
  final int attempts;

  /// Callback to execute when all permissions are accepted by user.
  final Function onAcceptedAllPermissions;

  /// Callback to execute when user has excedeed maximum limits of attempts to accept requests.
  final Function onExceededAttempts;

  @override
  State<TfPermissionsRequester> createState() => _TfPermissionsRequesterState();
}

class _TfPermissionsRequesterState extends State<TfPermissionsRequester>
    with WidgetsBindingObserver {
  /// Flag to indicate if app requires to reask for permissions.
  bool doReload = false;

  /// Number of attempts user has used to accept all permissions.
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
    // If app was paused.
    // This happens when setting page is opened.
    if (state == AppLifecycleState.paused) {
      doReload = true;
    }
    // If app was resumed.
    // This is the case when user returnes back to app from setting page.
    if (state == AppLifecycleState.resumed && doReload) {
      doReload = false;
      // Continue asking for permissions further.
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

  /// Handles different cases of permisssion acceptance status for all permissions.
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
