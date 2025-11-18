import 'package:flutter/material.dart';
import 'package:myapp/views/tela_login.dart';

void main() {
  runApp(ConversorMoedasApp());
}

class ConversorMoedasApp extends StatelessWidget {
  const ConversorMoedasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Conversor de Moedas")),
          backgroundColor: const Color.fromARGB(255, 255, 157, 19),
        ),
        body: const TelaLogin(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}