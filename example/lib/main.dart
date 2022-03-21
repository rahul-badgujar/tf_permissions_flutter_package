import 'package:flutter/material.dart';
import 'package:tf_permissions/tf_permissions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Permissions Page')),
      body: SizedBox.expand(
        child: TfPermissionsPage(
          permissionsRequired: [
            TfPermissionRequirement(
              permission: TfPermission.camera,
              whyRequirePermission:
                  'Example reason why camera permission is required.',
            ),
            TfPermissionRequirement(
              permission: TfPermission.storage,
              whyRequirePermission:
                  'Example reason why storage permission is required.',
            ),
          ],
        ),
      ),
    );
  }
}
