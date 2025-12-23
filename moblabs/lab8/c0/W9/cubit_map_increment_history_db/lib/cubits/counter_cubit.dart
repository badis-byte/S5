import 'package:bloc/bloc.dart';

import '../data/repo/history/history_repo_abstract.dart';

class CounterCubit extends Cubit<Map<String, dynamic>> {
  final repo = HistoryRepositoryBase.getInstance();
  CounterCubit() : super({'status': 'loading', 'count': 0, 'history': []}) {
    loadData();
  }
  Future<bool> loadData({int increment = 1}) async {
    print('Loading data from Cubit...');
    // Simulate loading data
    Map<String, dynamic> data = {
      'status': 'loading',
      'count': increment,
      'history': state['history'],
    };
    print('Emit : Loading data from Cubit...');
    emit(data);
    await Future.delayed(Duration(seconds: 3));
    try {
      final records = await repo.getData();
      print('Getting data from Repo...$records');
      Map<String, dynamic> data2 = {
        'status': 'done',
        'count': increment,
        'history': records,
      };
      emit(data2);
      print('Emit : data 2');
    } catch (e, stack) {
      print('$e --> $stack');
    }
    return true;
  }

  Future<bool> increment() async {
    await repo.insertData('Incremented');
    loadData(increment: state['count'] + 1);
    return true;
  }
}
