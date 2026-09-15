import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercício 2 - Barra de Botões',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Barra de Botões')),
      body: Center(
        child: Container(
          // Container só para dar um respiro (padding) ao redor da Row.
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: const IconButtonsBar(),
        ),
      ),
    );
  }
}

// Widget que representa a barra inteira com os 3 botões.
class IconButtonsBar extends StatelessWidget {
  const IconButtonsBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      // Distribui os 3 "botões" igualmente espaçados na horizontal.
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _IconLabelButton(icon: Icons.call, label: 'CALL'),
        _IconLabelButton(icon: Icons.navigation, label: 'ROUTE'),
        _IconLabelButton(icon: Icons.share, label: 'SHARE'),
      ],
    );
  }
}

// Widget reutilizável: um ícone em cima e um texto embaixo (Column).
// Criar um widget separado evita repetir código para cada botão.
class _IconLabelButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const _IconLabelButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final color = Colors.deepPurple[300];

    return Column(
      mainAxisSize: MainAxisSize.min, // ocupa só o espaço necessário
      children: [
        Icon(icon, color: color, size: 32),
        const SizedBox(height: 4), // pequeno espaçamento vertical
        Text(
          label,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
          ),
        ),
      ],
    );
  }
}
