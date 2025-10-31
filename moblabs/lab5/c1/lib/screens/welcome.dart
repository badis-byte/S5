import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Hello ENSIA Student!", style: TextStyle(fontSize: 24, color: Colors.black, decoration: TextDecoration.none),));
  }
}