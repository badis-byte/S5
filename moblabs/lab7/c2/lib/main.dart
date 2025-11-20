import 'package:flutter/material.dart';
import 'package:hello_getx/screens/home.dart';
import 'data/repo/history_repo_abstract.dart';

void main() async {
  await HistoryRepositoryBase.getInstance();
  runApp(const MainApp());
  
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}






