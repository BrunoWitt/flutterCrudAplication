import 'package:flutter/material.dart';
import 'pages/cadastro_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CadastroPage(),
    ),
  );
}
