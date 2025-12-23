import 'package:medbox/data/databases/db_record.dart';
import 'package:medbox/data/models/Result.dart';


final dbrecord = Records();
class ProfilesRepo {
  List<Map<String, dynamic>> data = [
    {'id': 1, 'name': 'Imed', 'dob': '2025-11-11'},
    {'id': 2, 'name': 'Asma', 'dob': '2023-11-01'},
  ];

    Future<List<Map<String, dynamic>>> getDeRecords() async {
    final data= await dbrecord.getRecords();
    return data;
  }


  Future<List<Map<String, dynamic>>> getData() async {
    await Future.delayed(Duration(seconds: 4));
    return data;
  }

  Future<ReturnResult> insertItem(Map<String, dynamic> record) async {
    await Future.delayed(Duration(seconds: 2));
    dbrecord.insertRecord(record);
    return ReturnResult(state: true, message: 'Record is inserted successully');
  }

  Future<ReturnResult> updateItem(Map<String, dynamic> record) async {
    await Future.delayed(Duration(seconds: 2));
    for (int i = 0; i < data.length; i++) {
      if (data[i]['id'] == record['id']) {
        if (data[i]['name'].length <= 2) {
          return ReturnResult(
            state: false,
            message: 'Name length should be > 2',
          );
        }
        data[i] = record;
      }
    }
    return ReturnResult(state: true, message: 'Record is updated successully');
  }

  Future<ReturnResult> deleteItem(int id) async {
    await Future.delayed(Duration(seconds: 2));
    dbrecord.deleteRecord(id);
        return ReturnResult(
          state: true,
          message: 'Record of id ($id) is deleted successully',
        );
  }
}
