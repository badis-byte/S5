import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_login_states/bloc/login/login_cubit.dart';

import '../bloc/login/login_state.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Logged In')),
        body: BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
          if (state is LoginSuccess)
            return Text(
              'Welcome ${state.username}',
              style: TextStyle(fontSize: 30),
            );
          else
            return Text(
              'Error,,,You should not be here...',
              style: TextStyle(fontSize: 30),
            );
        }));
  }
}
