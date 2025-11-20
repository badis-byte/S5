import 'package:flutter/material.dart';
import 'package:snake/screens/snake.dart';
import 'package:snake/screens/sneako.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return const MaterialApp(
    //   home: Snake(),
    // );
    return SnakeGameApp();
  }
}
