
import 'package:medbox/data/databases/db_base.dart';

class Records extends DBBaseTable {
  var db_table = 'record';
  static String sql_code = '''
          CREATE TABLE  record (
              id INTEGER PRIMARY KEY AUTOINCREMENT, 
              name TEXT NOT NULL,
              note TEXT UNIQUE NOT NULL,
              doctor TEXT NOT NULL,
            );
        ''';
}
