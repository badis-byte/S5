import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_cal/logic/cubit/math_cubit.dart';

class Result extends StatelessWidget {
  const Result({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // ElevatedButton(onPressed: () {
        //   context.read<MathCubit>().calculate();
        // }, child: Text('Compute')),
        Spacer(),
        BlocBuilder<MathCubit, List<dynamic>>(builder: (context, state){
          return Text( state[1]? "Result: ${state[0]}" : "${state[2]}");
        },),
        Spacer(),
      ],
    );
  }
}
