import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/counter_cubit.dart';

class WidgetOne extends StatelessWidget {
  const WidgetOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Value is :', style: TextStyle(fontSize: 30)),
        BlocBuilder<CounterCubit, Map<String, dynamic>>(
          builder: (context, state) {
            if (state['status'] == 'loading') {
              return CircularProgressIndicator();
            }
            if (state['status'] == 'error') {
              return Text('There is an error');
            }
            return Text('${state['count']}', style: TextStyle(fontSize: 30));
          },
        ),
        ElevatedButton(
          onPressed: () {
            context.read<CounterCubit>().increment();
          },
          child: Text('Increment'),
        ),
      ],
    );
  }
}
