import 'package:bloc/bloc.dart';

class CounterCubit extends Cubit<Map<String, dynamic>> {
  CounterCubit() : super({'status': 'loading', 'count': 0, 'history': []}) {
    loadData();
  }
  void loadData() {
    // Simulate loading data
    Map<String, dynamic> data = {
      'status': 'done',
      'count': 10,
      'history': ['2025-11-17 15:12:10', '2025-11-18 09:30:45'],
    };
    emit(data);
  }

  Future<bool> increment() async {
    emit({
      'status': 'loading',
      'count': state['count'],
      'history': state['history'],
    });
    await Future.delayed(Duration(seconds: 3));
    Map<String, dynamic> newState = {
      'status': 'done',
      'count': state['count'],
      'history': List<String>.from(state['history']),
    };
    newState['count'] += 1;
    newState['history'].add(DateTime.now().toString());
    emit(newState);
    return true;
  }
}
