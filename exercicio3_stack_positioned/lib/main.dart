import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercício 3 - Stack & Positioned',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stack & Positioned Widget')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SizedBox(
          // Precisamos de uma área com tamanho definido para o Stack
          // saber "onde" posicionar os filhos com Positioned.
          height: 300,
          width: double.infinity,
          child: Stack(
            children: [
              // 1º filho: fica no fundo da pilha.
              Positioned(
                top: 0,
                left: 0,
                child: _CardQuadrado(
                  label: 'Green',
                  color: Colors.green,
                ),
              ),
              // 2º filho: um pouco deslocado para baixo/direita, fica
              // por cima do "Green".
              Positioned(
                top: 30,
                left: 30,
                child: _CardQuadrado(
                  label: 'Red',
                  color: Colors.red,
                ),
              ),
              // 3º filho: mais deslocado ainda, fica por cima de todos.
              Positioned(
                top: 60,
                left: 60,
                child: _CardQuadrado(
                  label: 'Purple',
                  color: Colors.purple,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget reutilizável para desenhar cada "cartão" colorido com um
// rótulo (Text) no canto superior esquerdo.
class _CardQuadrado extends StatelessWidget {
  final String label;
  final Color color;

  const _CardQuadrado({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 180,
      color: color,
      padding: const EdgeInsets.all(8),
      alignment: Alignment.topLeft,
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
