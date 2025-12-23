import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:medbox/data/repositories/profiles/profile_repo.dart';
import 'package:medbox/logic/cubits/profiles_cubit.dart';
import 'package:medbox/logic/cubits/records_cubit.dart';
import 'package:medbox/presentation/screens/profiles/profile_screen.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'dart:io' show Platform;

import 'src/generated/l10n/app_localizations.dart';

Future<bool> init_my_app() async {
  // if (Platform.isLinux || Platform.isWindows) {
  //   sqfliteFfiInit();
  //   databaseFactory = databaseFactoryFfi;
  // }

  final sl = GetIt.instance;
  sl.registerLazySingleton<ProfilesRepo>(() => ProfilesRepo());
  WidgetsFlutterBinding.ensureInitialized();
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
      providers: [BlocProvider(create: (_) => ProfilesCubit()),
      BlocProvider(create: (_) => RecordsCubit())],
      child: const MaterialApp(
        locale: Locale('ar'),
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [Locale('en'), Locale('ar'), Locale('ar')],
        home: ProfileScreen(),
      ),
    );
  }
}
