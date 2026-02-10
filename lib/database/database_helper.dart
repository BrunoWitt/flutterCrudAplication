import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  static Future<Database> getDatabase() async {
    if (_database != null)
      return _database!; //Cria o banco de dados caso não tenha

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'simple_crud.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE cadastro (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            texto TEXT NOT NULL,
            numero INTEGER NOT NULL UNIQUE CHECK (numero > 0)
          );
        ''');

        await db.execute('''
          CREATE TABLE log_operacoes (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            operacao TEXT NOT NULL,
            data_hora TEXT NOT NULL
          );
        ''');

        await db.execute('''
          CREATE TRIGGER log_insert
          AFTER INSERT ON cadastro
          BEGIN
            INSERT INTO log_operacoes (operacao, data_hora)
            VALUES ('INSERT', datetime('now'));
          END;
        ''');

        await db.execute('''
          CREATE TRIGGER log_update
          AFTER UPDATE ON cadastro
          BEGIN
            INSERT INTO log_operacoes (operacao, data_hora)
            VALUES ('UPDATE', datetime('now'));
          END;
        ''');

        await db.execute('''
          CREATE TRIGGER log_delete
          AFTER DELETE ON cadastro
          BEGIN
            INSERT INTO log_operacoes (operacao, data_hora)
            VALUES ('DELETE', datetime('now'));
          END;
        ''');
      },
    );

    return _database!;
  }
}
