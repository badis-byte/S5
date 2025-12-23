import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_cal/logic/cubit/math_cubit.dart';
import 'package:simple_cal/presentation/screens/home_screen.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
   Widget build(BuildContext context) {
   return MultiBlocProvider(
       providers: [
         BlocProvider(create: (_) => MathCubit()),
       ],
       child: MaterialApp(
         home: HomeScreen(),
       ));
 }
}

