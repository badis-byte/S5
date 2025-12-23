import 'package:cubic_counter_simple/views/widgetTwo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/counter_cubit.dart';
import 'widgetOne.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Increment App : Cubit'),
      ),
      body: Column(
        children: [
          WidgetOne(),
          SizedBox(
            height: 20,
          ),
          WidgetTwo(),
        ],
      ),
    );
  }
}
