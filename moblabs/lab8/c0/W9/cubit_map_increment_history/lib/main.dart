import 'package:cubit_map_increment_history/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubits/counter_cubit.dart';

Future<bool> init_my_app() async {
  return true;
}

void main() async {
  await init_my_app();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => CounterCubit())],
      child: MaterialApp(home: HomeScreen()),
    );
  }
}
