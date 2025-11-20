import 'package:flutter/material.dart';

class Fight extends StatefulWidget {
  const Fight({super.key});

  @override
  State<Fight> createState() => _FightState();
}

class _FightState extends State<Fight> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fight Screen",),
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              for( var x =0; x < 15; x++)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
              )
            ],
          ),
        )
    );
  }
}