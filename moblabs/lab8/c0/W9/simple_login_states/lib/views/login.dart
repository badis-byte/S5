import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_login_states/views/welcome.dart';

import '../bloc/login/login_cubit.dart';
import '../bloc/login/login_state.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login Screen..')),
      body: Center(
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginError) {
              // Show error snackbar
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  duration: Duration(seconds: 3),
                ),
              );
            }
            if (state is LoginSuccess) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => WelcomeScreen()),
                (route) =>
                    false, // This condition removes all routes from the stack
              );

              // Show error snackbar
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Logged successfully...'),
                  duration: Duration(seconds: 3),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is LoginInitial || state is LoginError) {
              return getLoginUI(context);
            } else if (state is LoginLoading) {
              return const CircularProgressIndicator();
            } else {
              return const Text('Something went wrong');
            }
          },
        ),
      ),
    );
  }

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Widget getLoginUI(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Username Field
        TextField(
          controller: usernameController,
          decoration: InputDecoration(
            labelText: 'Username',
            prefixIcon: const Icon(Icons.person),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        // Password Field
        TextField(
          controller: passwordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            prefixIcon: const Icon(Icons.lock),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        const SizedBox(height: 24.0),
        // Login Button
        ElevatedButton(
          onPressed: () {
            String username = usernameController.text;
            String password = passwordController.text;
            context.read<LoginCubit>().actionProcessLogin(username, password);
          },
          style: ElevatedButton.styleFrom(
            padding:
                const EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
          ),
          child: const Text(
            'Login',
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      ],
    );
  }
}
