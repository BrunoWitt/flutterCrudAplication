import 'package:flutter/material.dart';
import '../models/cadastro.dart';
import '../repositories/cadastro_repository.dart';

class CadastroPage extends StatefulWidget {
  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final repo = CadastroRepository();
  final textoController = TextEditingController();
  final numeroController = TextEditingController();

  List<Cadastro> lista = [];
  bool editando = false;

  @override
  void initState() {
    super.initState();
    carregarLista();
  }

  Future<void> carregarLista() async {
    lista = await repo.listar();
    setState(() {});
  }

  Future<void> salvar() async {
    final texto = textoController.text;
    final numeroString = numeroController.text.trim();

    if (texto.isEmpty || numeroString.isEmpty) {
      mostrarErro('Todos os campos são obrigatórios.');
      return;
    }

    final numero = int.tryParse(numeroString) ?? 0;

    final cadastro = Cadastro(texto: texto, numero: numero);

    try {
      if (editando) {
        await repo.atualizar(cadastro);
      } else {
        await repo.inserir(cadastro);
      }

      limparCampos();
      carregarLista();
    } catch (e) {
      mostrarErro(e.toString());
    }
  }

  void limparCampos() {
    textoController.clear();
    numeroController.clear();
    editando = false;
  }

  void mostrarErro(String msg) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Erro'),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: numeroController,
              keyboardType: TextInputType.number,
              enabled: !editando,
              decoration: InputDecoration(labelText: 'Número'),
            ),
            TextField(
              controller: textoController,
              decoration: InputDecoration(labelText: 'Texto'),
            ),
            ElevatedButton(
              onPressed: salvar,
              child: Text(editando ? 'Atualizar' : 'Adicionar'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: lista.length,
                itemBuilder: (_, i) {
                  final item = lista[i];
                  return ListTile(
                    title: Text(item.texto),
                    subtitle: Text('Número: ${item.numero}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            textoController.text = item.texto;
                            numeroController.text = item.numero.toString();
                            editando = true;
                            setState(() {});
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                            await repo.deletar(item);
                            carregarLista();
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
