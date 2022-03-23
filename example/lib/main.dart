import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tf_data_streamer/tf_data_streamer.dart';
import 'package:tf_permissions/tf_permissions.dart';

void main() {
  runApp(const MyApp());
}

class PermissionEventStreamer extends TfDataStreamer<int> {
  int counter = 0;
  Future<int> askForPermissions() async {
    if (counter == 5) {
      return -1;
    }
    Map<TfPermissionName, TfPermissionStatus> result =
        await requestPermissions(permissionsNames: [
      TfPermissionName.storage,
      TfPermissionName.locationAlways,
      TfPermissionName.camera
    ]);
    if (result.containsValue(TfPermissionStatus.denied)) {
      counter++;
      return await askForPermissions();
    } else if (result.containsValue(TfPermissionStatus.permanentlyDenied) ||
        result.containsValue(TfPermissionStatus.restricted)) {
      return 0;
    }
    return 1;
  }

  @override
  void reload() {
    // -1 exit
    // 0 refresh
    // 1 success
    askForPermissions().then((value) => addData(value));
  }
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

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final permissionEventStreamer = PermissionEventStreamer();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    permissionEventStreamer.init();
  }

  @override
  void dispose() {
    permissionEventStreamer.dispose();
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      permissionEventStreamer.reload();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Permissions Page')),
      body: StreamBuilder<int>(
        stream: permissionEventStreamer.stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final result = snapshot.data ?? 0;
          if (result == -1) {
            Navigator.pop(context);
          } else if (result == 1) {
            // redirect user
          }
          /* if (!r) {
            return const Center(
              child: Text("Permissions Denied"),
            );
          }
          return const Center(
            child: Text("Permissions Granted"),
          ); */
          return const SizedBox();
        },
      ),
    );
  }
}
