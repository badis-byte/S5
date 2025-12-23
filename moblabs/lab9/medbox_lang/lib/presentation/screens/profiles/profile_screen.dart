import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medbox/logic/cubits/profiles_cubit.dart';
import 'package:medbox/logic/cubits/records_cubit.dart';
import 'package:medbox/presentation/screens/profiles/profile_add_edit.dart';
import 'package:medbox/presentation/screens/profiles/profile_card.dart';

import '../../../src/generated/l10n/app_localizations.dart';
import '../medical_records/record.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.profiles)),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => Record()),
          );
        },
      ),
      body: Center(
        child: Container(
          child: BlocConsumer<RecordsCubit, Map<String, dynamic>>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state['state'] == 'loading') {
                return CircularProgressIndicator();
              }
              if (state['state'] == 'error') {
                return Text('Error....${state['data']['message']}');
              }

              return ListView.builder(
                itemCount: state['data'].length,
                itemBuilder: (context, index) {
                  return ProfileCard(data: state['data'][index]);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
