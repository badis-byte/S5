import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:medbox/data/repositories/profiles/profile_repo.dart';

import '../../data/models/Result.dart';

class RecordsCubit extends Cubit<Map<String, dynamic>> {
  late final ProfilesRepo profileRepo;

  RecordsCubit() : super({'data': [], 'state': 'loading', 'message': ''}) {
    profileRepo = GetIt.I<ProfilesRepo>();
    load();
  }

  Future<bool> load() async {
    emit({...state, 'state': 'loading', 'message': '', 'data': []});
    try {
      final records = await profileRepo.getDeRecords();
      print('Load Data.....................${records.toString()}');
      emit({...state, 'data': records, 'state': 'done', 'message': ''});
    } catch (e) {
      emit({...state, 'state': 'error', 'message': e.toString(), 'data': []});
    }
    return true;
  }

  Future<ReturnResult> insertItem(Map<String, dynamic> record) async {
    var result = ReturnResult(state: false, message: 'There is an error');
    try {
      result = await profileRepo.insertItem(record);
      await load();
    } catch (e) {
      emit({...state, 'error': e.toString(), 'data': []});
    }
    return result;
  }

  Future<ReturnResult> updateItem(Map<String, dynamic> record) async {
    var result = ReturnResult(state: false, message: 'There is an error');
    try {
      result = await profileRepo.updateItem(record);
      await load();
    } catch (e) {
      emit({...state, 'error': e.toString(), 'data': []});
    }
    return result;
  }

  Future<ReturnResult> deleteItem(int id) async {
    var result = ReturnResult(state: false, message: 'There is an error');
    try {
      result = await profileRepo.deleteItem(id);
      await load();
    } catch (e) {
      emit({...state, 'state': 'error', 'message': e.toString(), 'data': []});
    }
    return result;
  }
}
