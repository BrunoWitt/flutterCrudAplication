import '../database/database_helper.dart';
import '../models/cadastro.dart';

class CadastroRepository {

  Future<void> inserir(Cadastro cadastro) async {
    final db = await DatabaseHelper.getDatabase();

    try {
      await db.insert('cadastro', cadastro.toMap());
    } catch (e) {
      throw Exception('Já existe um cadastro com esse número.');
    }
  }

  Future<List<Cadastro>> listar() async {
    final db = await DatabaseHelper.getDatabase();

    final result = await db.query('cadastro');

    return result.map((e) => Cadastro.fromMap(e)).toList();
  }

  Future<void> atualizar(Cadastro cadastro) async {
    final db = await DatabaseHelper.getDatabase();

    await db.update(
      'cadastro',
      {'texto': cadastro.texto},
      where: 'numero = ?',
      whereArgs: [cadastro.numero],
    );
  }

  Future<void> deletar(Cadastro cadastro) async {
    final db = await DatabaseHelper.getDatabase();

    await db.delete(
      'cadastro',
      where: 'numero = ?',
      whereArgs: [cadastro.numero],
    );
  }
}
