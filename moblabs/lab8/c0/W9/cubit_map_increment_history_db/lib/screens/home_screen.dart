import 'package:flutter/material.dart';

import 'widget_double.dart';
import 'widget_history.dart';
import 'widget_one.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Increment App : Cubit')),
      body: Column(
        children: [
          Row(children: [WidgetOne(), SizedBox(width: 30), WidgetTwo()]),
          SizedBox(height: 20),
          WidgetHistory(),
        ],
      ),
    );
  }
}
