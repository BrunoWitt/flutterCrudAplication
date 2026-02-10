import 'package:flutter/material.dart';
import 'pages/cadastro_page.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux) {
    // Inicializa a factory do banco de dados para Desktop
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: CadastroPage()));
}
