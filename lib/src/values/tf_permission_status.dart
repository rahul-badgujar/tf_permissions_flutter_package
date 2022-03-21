/*
MODIFIED
Source: https://pub.dev/packages/permission_handler
*/

/// Defines the state of a [Permission].
enum TfPermissionStatus {
  /// The user denied access to the requested feature.
  denied,

  /// The user granted access to the requested feature.
  granted,

  /// The OS denied access to the requested feature. The user cannot change
  /// this app's status, possibly due to active restrictions such as parental
  /// controls being in place.
  /// *Only supported on iOS.*
  restricted,

  ///User has authorized this application for limited access.
  /// *Only supported on iOS (iOS14+).*
  limited,

  /// Permission to the requested feature is permanently denied, the permission
  /// dialog will not be shown when requesting this permission. The user may
  /// still change the permission status in the settings.
  /// *Only supported on Android.*
  permanentlyDenied,
}

/* 
/// Conversion extension methods for the [TfPermissionStatus] type.
extension TfPermissionStatusValue on TfPermissionStatus {
  /// Converts the [TfPermissionStatus] value into an integer.
  int get value {
    switch (this) {
      case TfPermissionStatus.denied:
        return 0;
      case TfPermissionStatus.granted:
        return 1;
      case TfPermissionStatus.restricted:
        return 2;
      case TfPermissionStatus.limited:
        return 3;
      case TfPermissionStatus.permanentlyDenied:
        return 4;
      default:
        throw UnimplementedError();
    }
  }

  /// Converts the supplied integer value into a [TfPermissionStatus] enum.
  static TfPermissionStatus statusByValue(int value) {
    return [
      TfPermissionStatus.denied,
      TfPermissionStatus.granted,
      TfPermissionStatus.restricted,
      TfPermissionStatus.limited,
      TfPermissionStatus.permanentlyDenied,
    ][value];
  }
}
 */
/// Utility getter extensions for the [TfPermissionStatus] type.
extension TfPermissionStatusGetters on TfPermissionStatus {
  /// If the user denied access to the requested feature.
  bool get isDenied => this == TfPermissionStatus.denied;

  /// If the user granted access to the requested feature.
  bool get isGranted => this == TfPermissionStatus.granted;

  /// If the OS denied access to the requested feature. The user cannot change
  /// this app's status, possibly due to active restrictions such as parental
  /// controls being in place.
  /// *Only supported on iOS.*
  bool get isRestricted => this == TfPermissionStatus.restricted;

  /// If the user denied access to the requested feature and selected to never
  /// again show a request for this permission. The user may still change the
  /// permission status in the settings.
  /// *Only supported on Android.*
  ///
  /// WARNING: This can only be determined AFTER requesting this permission.
  /// Therefore make a `request` call first.
  bool get isPermanentlyDenied => this == TfPermissionStatus.permanentlyDenied;

  /// Indicates that permission for limited use of the resource is granted.
  bool get isLimited => this == TfPermissionStatus.limited;
}

/// Utility getter extensions for the `Future<PermissionStatus>` type.
extension FutureTfPermissionStatusGetters on Future<TfPermissionStatus> {
  /// If the user granted access to the requested feature.
  Future<bool> get isGranted async => (await this).isGranted;

  /// If the user denied access to the requested feature.
  Future<bool> get isDenied async => (await this).isDenied;

  /// If the OS denied access to the requested feature. The user cannot change
  /// this app's status, possibly due to active restrictions such as parental
  /// controls being in place.
  /// *Only supported on iOS.*
  Future<bool> get isRestricted async => (await this).isRestricted;

  /// If the user denied access to the requested feature and selected to never
  /// again show a request for this permission. The user may still change the
  /// permission status in the settings.
  /// *Only supported on Android.*
  Future<bool> get isPermanentlyDenied async =>
      (await this).isPermanentlyDenied;

  /// Indicates that permission for limited use of the resource is granted.
  Future<bool> get isLimited async => (await this).isLimited;
}
