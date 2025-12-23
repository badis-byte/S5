import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_cal/logic/cubit/math_cubit.dart';

class WidgetOne extends StatelessWidget {
  const WidgetOne({super.key});

  @override
  Widget build(BuildContext context) {
    var ans = 0;
    return TextField(
      onChanged: (value) {
        try{
          ans = int.parse(value);
        }catch(e){
          ans = 0;
        }
        context.read<MathCubit>().setFirst(ans);
      },
      keyboardType: TextInputType.numberWithOptions(),
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'First number',
      ),
    );
  }
}

