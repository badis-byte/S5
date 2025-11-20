import 'package:c1/screens/form.dart';
import 'package:c1/screens/logged.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  init_app();

  runApp(const MainApp());
}

Future<bool> init_app()async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String user = prefs.getString("user") ?? "";
  return true;
}


class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Forms(),
      routes: {
        "/form": (context) => Forms(),
        "/logged": (context) => Logged(),
      },
    );
  }
}
