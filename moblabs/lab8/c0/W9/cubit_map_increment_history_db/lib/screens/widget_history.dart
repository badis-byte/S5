import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/counter_cubit.dart';

class WidgetHistory extends StatelessWidget {
  const WidgetHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterCubit, Map<String, dynamic>>(
      builder: (context, state) {
        if (state['status'] == 'loading') {
          return CircularProgressIndicator();
        }
        return Expanded(
          child: ListView.builder(
            itemCount: state['history'].length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 4,
                child: Text('${state['history'][index]}'),
              );
            },
          ),
        );
      },
    );
  }
}
