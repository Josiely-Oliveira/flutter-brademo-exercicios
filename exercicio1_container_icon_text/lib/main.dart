import 'package:flutter/material.dart';

void main() {
  // runApp() é sempre o ponto de entrada de um app Flutter.
  // Ele recebe um Widget (a raiz da árvore de widgets).
  runApp(const MyApp());
}

// MyApp é o Widget raiz do aplicativo.
// Extende StatelessWidget porque essa tela não muda de estado
// (não há nada que precise ser "redesenhado" dinamicamente).
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercício 1 - Container/Icon/Text',
      debugShowCheckedModeBanner: false, // remove a faixa "DEBUG"
      theme: ThemeData(primarySwatch: Colors.green),
      home: const HomePage(),
    );
  }
}

// HomePage representa a tela principal do exercício.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold fornece a estrutura básica de uma tela Material:
      // AppBar (barra superior) + body (conteúdo principal).
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: const Text(
          'Flutter is Fun!',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        // Center centraliza o widget filho dentro do espaço disponível.
        child: Container(
          // Container permite customizar tamanho, cor, borda, etc.
          width: 150,
          height: 150,
          color: Colors.deepOrangeAccent, // cor de fundo do quadrado
          alignment: Alignment.center,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Row para colocar o texto e o ícone lado a lado
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Hi Mom',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.emoji_emotions, color: Colors.amber, size: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
