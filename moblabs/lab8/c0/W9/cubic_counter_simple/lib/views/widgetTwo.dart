import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/counter_cubit.dart';

class WidgetTwo extends StatelessWidget {
  const WidgetTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterCubit, int>(
      builder: (context, count) {
        return Text(
          'Double of Increment is : ${2 * count}',
          style: TextStyle(fontSize: 30),
        );
      },
    );
  }
}
