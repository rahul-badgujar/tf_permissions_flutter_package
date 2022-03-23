import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      body: FutureBuilder(
        future: askForPermissions(context),
        builder: (context, snapshot){
          if(snapshot.hasError){
            return Center(
            child: Text(snapshot.error.toString()),
            );
          }
          if(!snapshot.hasData){
            return const Center(child: CircularProgressIndicator());
          }
          return const Center(
            child: Text("Permissions Granted"),
          );
        },
      ),
    );
  }

  Future<bool> askForPermissions(BuildContext context, {int count = 0}) async {
    if(count == 5){
      Navigator.pop(context);
    }
    Map<TfPermissionName, bool> result = await requestPermissions(
      permissionsNames: [
        TfPermissionName.storage,
        TfPermissionName.locationAlways,
        TfPermissionName.camera
      ]
    );
    if(result.containsValue(false)){
      return await askForPermissions(context, count: count+1);
    }
    return true;
  }

}
