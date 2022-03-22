/*
MODIFIED
Source: https://pub.dev/packages/permission_handler
*/

/// Enumerators for various permissions.
enum TfPermissionName {
  /// Android: Calendar
  /// iOS: Calendar (Events)
  calendar,

  /// Android: Camera
  /// iOS: Photos (Camera Roll and Camera)
  camera,

  /// Android: Contacts
  /// iOS: AddressBook
  contacts,

  /// Android: Fine and Coarse Location
  /// iOS: CoreLocation (Always and WhenInUse)
  location,

  /// Android:
  ///   When running on Android < Q: Fine and Coarse Location
  ///   When running on Android Q and above: Background Location Permission
  /// iOS: CoreLocation - Always
  ///   When requesting this permission the user needs to grant permission
  ///   for the `locationWhenInUse` permission first, clicking on
  ///   the `Àllow While Using App` option on the popup.
  ///   After allowing the permission the user can request the `locationAlways`
  ///   permission and can click on the `Change To Always Allow` option.
  locationAlways,

  /// Android: Fine and Coarse Location
  /// iOS: CoreLocation - WhenInUse
  locationWhenInUse,

  /// Android: None
  /// iOS: MPMediaLibrary
  mediaLibrary,

  /// Android: Microphone
  /// iOS: Microphone
  microphone,

  /// Android: Phone
  /// iOS: Nothing
  phone,

  /// Android: Nothing
  /// iOS: Photos
  /// iOS 14+ read & write access level
  photos,

  /// Android: Nothing
  /// iOS: Photos
  /// iOS 14+ read & write access level
  photosAddOnly,

  /// Android: Nothing
  /// iOS: Reminders
  reminders,

  /// Android: Body Sensors
  /// iOS: CoreMotion
  sensors,

  /// Android: Sms
  /// iOS: Nothing
  sms,

  /// Android: Microphone
  /// iOS: Speech
  speech,

  /// Android: External Storage
  /// iOS: Access to folders like `Documents` or `Downloads`. Implicitly
  /// granted.
  storage,

  /// Android: Ignore Battery Optimizations
  ignoreBatteryOptimizations,

  /// Android: Notification
  /// iOS: Notification
  notification,

  /// Android: Allows an application to access any geographic locations
  /// persisted in the user's shared collection.
  accessMediaLocation,

  /// When running on Android Q and above: Activity Recognition
  /// When running on Android < Q: Nothing
  /// iOS: Nothing
  activityRecognition,

  /// The unknown only used for return type, never requested
  unknown,

  /// iOS 13 and above: The authorization state of Core Bluetooth manager.
  /// When running < iOS 13 or Android this is always allowed.
  bluetooth,

  /// Android: Allows an application a broad access to external storage in
  /// scoped storage.
  /// iOS: Nothing
  ///
  /// You should request the Manage External Storage permission only when
  /// your app cannot effectively make use of the more privacy-friendly APIs.
  /// For more information: https://developer.android.com/training/data-storage/manage-all-files
  ///
  /// When the privacy-friendly APIs (i.e. [Storage Access Framework](https://developer.android.com/guide/topics/providers/document-provider)
  /// or the [MediaStore](https://developer.android.com/training/data-storage/shared/media) APIs) is all your app needs the
  /// [PermissionGroup.storage] are the only permissions you need to request.
  ///
  /// If the usage of the Manage External Storage permission is needed,
  /// you have to fill out the Permission Declaration Form upon submitting
  /// your app to the Google Play Store. More details can be found here:
  /// https://support.google.com/googleplay/android-developer/answer/9214102#zippy=
  manageExternalStorage,

  ///Android: Allows an app to create windows shown on top of all other apps
  ///iOS: Nothing
  systemAlertWindow,

  ///Android: Allows an app to request installing packages.
  ///iOS: Nothing
  requestInstallPackages,

  ///Android: Nothing
  ///iOS: Allows user to accept that your app collects data about end users and
  ///shares it with other companies for purposes of tracking across apps and
  ///websites.
  appTrackingTransparency,

  ///Android: Nothing
  ///iOS: Notifications that override your ringer
  criticalAlerts,

  ///Android: Allows the user to access the notification policy of the phone.
  /// EX: Allows app to turn on and off do-not-disturb.
  ///iOS: Nothing
  accessNotificationPolicy,

  ///Android: Allows the user to look for Bluetooth devices
  ///(e.g. BLE peripherals).
  ///iOS: Nothing
  bluetoothScan,

  ///Android: Allows the user to make this device discoverable to other
  ///Bluetooth devices.
  ///iOS: Nothing
  bluetoothAdvertise,

  ///Android: Allows the user to connect with already paired Bluetooth devices.
  ///iOS: Nothing
  bluetoothConnect,
}
