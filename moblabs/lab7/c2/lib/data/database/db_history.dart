import 'package:sqflite/sqflite.dart';

import 'db_base.dart';

class DBHistoryTable extends DBBaseTable {
  var db_table = 'history';
  static String sql_code = '''
          CREATE TABLE  history (
              id INTEGER PRIMARY KEY AUTOINCREMENT, 
              message TEXT, 
              create_date TEXT
            )
        ''';
}
