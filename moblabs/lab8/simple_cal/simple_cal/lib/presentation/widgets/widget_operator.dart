import 'package:flutter/material.dart';
import 'package:simple_cal/logic/cubit/math_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WidgetOperator extends StatelessWidget {
  const WidgetOperator({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        context.read<MathCubit>().setSecond(value);
      },
      keyboardType: TextInputType.numberWithOptions(),
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Operator : + , * , - or /',
      ),
    );
  }
}
