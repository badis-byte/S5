import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/counter_cubit.dart';

class WidgetTwo extends StatelessWidget {
  const WidgetTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterCubit, Map<String, dynamic>>(
      builder: (context, state) {
        if (state['status'] == 'loading') {
          return CircularProgressIndicator();
        }
        return Text(
          'Double is :\n ${2 * state['count']}',
          style: TextStyle(fontSize: 20),
        );
      },
    );
  }
}
