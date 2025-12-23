import '../../databases/db_history.dart';
import 'history_repo_abstract.dart';

class HistoryRepository extends HistoryRepositoryBase {
  final DB_HISTORY = DBHistoryTable(); // Badly Coupled..

  @override
  Future<List<String>> getData() async {
    List<Map> obj = await DB_HISTORY.getRecords();
    List<String> result = [];
    obj.forEach((item) {
      result.add(item['message'] + ' ' + item['create_date']);
    });
    return result;
  }

  @override
  Future<bool> insertData(String item) async {
    DB_HISTORY.insertRecord({
      'message': item,
      'create_date': DateTime.now().toString(),
    });
    return true;
  }
}
