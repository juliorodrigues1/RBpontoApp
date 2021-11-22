import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

recuperarBancoDados() async {
  final caminhoBancoDados = await getDatabasesPath();
  final localBancoDados = join(caminhoBancoDados, "ponto.db");

  var db = await openDatabase(
      localBancoDados,
      version: 10,
      onCreate: (db, dbVersaoRecente){
        String sql = "CREATE TABLE work_days (id INTEGER PRIMARY KEY AUTOINCREMENT, employ_id INTEGER, lat TEXT, long TEXT, point text)";
        db.execute(sql);
      }
  );

  print("aberto: " + db.isOpen.toString());
  return db;
}