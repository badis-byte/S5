import 'package:flutter/material.dart';
import 'package:simple_cal/presentation/widgets/widget_result.dart';

import '../widgets/widget_one.dart';
import '../widgets/widget_operator.dart';
import '../widgets/widget_two.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Simple Calculator')),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            WidgetOne(),
            SizedBox(height: 10),
            WidgetOperator(),
            SizedBox(height: 10),
            WidgetTwo(),
            SizedBox(height: 10),
            Result(),
          ],
        ),
      ),
    );
  }
}
