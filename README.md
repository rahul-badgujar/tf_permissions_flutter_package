# tf_permissions

Get utility Widgets and Functions to deal with all the permissions your app requires collectively and all at once.

## Supported Flutter Versions

Flutter SDK: >=1.17.0

## Installation

Add the Package

```yaml
dependencies:
  tf_permissions:
    git:
      url: https://github.com/rahul-badgujar/tf_permissions_flutter_package.git
      ref: main
```

## How to use

Import the package in your dart file

```dart
import 'package:tf_permissions/tf_permissions.dart';
```

### TfPermissionsRequester Widget to Requests Permissions

```dart
TfPermissionsRequester(
    // List of TfPermissionName you want to request.
    permissionsRequired: const [
        TfPermissionName.camera,
        TfPermissionName.location,
        TfPermissionName.storage,
    ],
    // Maximum attempts for user to accept all requests. 
    attempts: 3,
    // Callback to execute when all permissions are accepted by user.
    onAcceptedAllPermissions: () {
        // E.g., Navigating to Home Page.
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
            builder: ((context) => const HomePage()),
            ),
        );
    },
    // Callback to execute when user has excedeed maximum limits of attempts to accept requests.
    onExceededAttempts: () {
        // E.g., Closing the page
        if (Navigator.canPop(context)) {
            Navigator.pop(context);
        }
    },
    // Widget to show while asking for permissions.
    child: const Scaffold(
        body: Center(
            child: Text("Asking For Permissions"),
        ),
    ),
)
```

### Currently Supported TfPermissions

- TfPermissionName.camera
- TfPermissionName.location
- TfPermissionName.locationAlways
- TfPermissionName.storage

Note: The widget throws UnimplementedError if implementation is not added for any of required permissions.

### Additional Information

- If the user has Permanently Denied or Restricted the Permission, User will be promoted with App Settings (or App Info) Page to allow the permission.
- kept showing settings page if he keeps permanently denying permissions. If user keeps permanently denying permissions, the App Info Page will be kept showing undefinately.
