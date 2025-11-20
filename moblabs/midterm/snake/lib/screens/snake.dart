import 'package:flutter/material.dart';

class Snake extends StatefulWidget {
  const Snake({super.key});

  @override
  State<Snake> createState() => _SnakeState();
}

class _SnakeState extends State<Snake> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snake Screen'),
      ),
      body: const Center(
        child: Text('This is the Snake Screen'),
      ),
    );
  }
}