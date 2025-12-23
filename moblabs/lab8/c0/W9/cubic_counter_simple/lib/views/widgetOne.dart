import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/counter_cubit.dart';

class WidgetOne extends StatelessWidget {
  const WidgetOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(
        'Value is :',
        style: TextStyle(fontSize: 30),
      ),
      BlocBuilder<CounterCubit, int>(
        builder: (context, count) {
          return Text(
            '$count',
            style: TextStyle(fontSize: 30),
          );
        },
      ),
      ElevatedButton(
          onPressed: () {
            context.read<CounterCubit>().increment();
          },
          child: Text('Increment')),
    ]);
  }
}
