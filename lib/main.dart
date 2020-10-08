import 'package:flutter/material.dart';
import 'screens/login.dart';
import 'strings.dart';
import 'theme.dart' as Theme;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.appName,
      theme: Theme.CriberThemeData,
      home: Login(),
    );
  }
}
