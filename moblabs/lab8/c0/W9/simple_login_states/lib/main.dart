import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_login_states/views/login.dart';

import 'bloc/login/login_cubit.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => LoginCubit()),
        ],
        child: MaterialApp(
          home: LoginScreen(),
          debugShowCheckedModeBanner: false,
        ));
  }
}
