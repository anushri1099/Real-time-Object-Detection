import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'login.dart';
import 'credentials.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      masterKey: keyClientKey, debug: true);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login/Logout',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.dark,
      ),
      home: Login(),
    );
  }
}
