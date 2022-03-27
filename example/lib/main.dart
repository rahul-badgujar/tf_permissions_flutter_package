import 'package:flutter/material.dart';
import 'package:tf_permissions/tf_permissions.dart';

void main() {
  runApp(const MyApp());
}

int counter = 0;
bool doReload = false;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PermissionRequestWrapper(),
    );
  }
}

class PermissionRequestWrapper extends StatelessWidget {
  const PermissionRequestWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TfPermissionsRequester(
      permissionsRequired: const [
        TfPermissionName.camera,
        TfPermissionName.locationAlways,
        TfPermissionName.storage,
      ],
      attempts: 3,
      onAcceptedAllPermissions: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: ((context) => const HomePage()),
          ),
        );
      },
      onExceededAttempts: () {
        // Closing the page
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: const Center(
        child: Text(
          "All permissions accepted. Do your stuff here",
        ),
      ),
    );
  }
}
