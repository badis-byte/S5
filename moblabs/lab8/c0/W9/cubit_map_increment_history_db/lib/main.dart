import 'dart:io';

import 'package:cubit_map_increment_history/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'cubits/counter_cubit.dart';
import 'data/repo/history/history_repo_abstract.dart';

Future<bool> init_my_app() async {
  final historyRepo = HistoryRepositoryBase.getInstance();
  return true;
}

void main() async {
  if (Platform.isLinux || Platform.isWindows) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  WidgetsFlutterBinding.ensureInitialized();

  await init_my_app();

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => CounterCubit())],
      child: MaterialApp(home: HomeScreen()),
    );
  }
}
