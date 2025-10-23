import 'package:flutter/material.dart';

class Reverse extends StatefulWidget {
  const Reverse({super.key});

  @override
  State<Reverse> createState() => _ReverseState();
}

class _ReverseState extends State<Reverse> {
  String reversedText = '';
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(15),
    child: Column(
      children: [
        Container(
          color: Colors.blue,
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Type something to see it reversed',
            ),
            onChanged: (text) {
              reversedText = text;
            },
          ),
        ),
        Spacer(),

      ],
    )
    );
  }
}