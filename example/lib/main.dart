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
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    askForPermissions().then((value) {
      if (value == -1) {
        closePage(context);
      }
    });
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
      askForPermissions().then((value) {
        if (value == -1) {
          closePage(context);
        }
      });
    }
  }

  void closePage(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Permissions Page')),
      body: const SizedBox(),
    );
  }

  Future<int> askForPermissions() async {
    if (counter == 5) {
      Navigator.pop(context);
      return -1;
    }
    Map<TfPermissionName, TfPermissionStatus> result =
        await requestPermissions(permissionsNames: [
      TfPermissionName.storage,
      TfPermissionName.locationAlways,
      TfPermissionName.camera
    ]);
    if (result.containsValue(TfPermissionStatus.permanentlyDenied) ||
        result.containsValue(TfPermissionStatus.restricted)) {
      return 0;
    } else if (result.containsValue(TfPermissionStatus.denied)) {
      counter++;
      return await askForPermissions();
    }
    return 1;
  }
}
