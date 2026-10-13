import 'package:flutter/material.dart';

void main() => runApp(const Exercicio2App());

class Exercicio2App extends StatelessWidget {
  const Exercicio2App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Exercício 2 - Theme sobrescrito',
      // ThemeData inicial: background azul.
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Widget que usa o ThemeData original (azul).
          const Expanded(child: ThemedBox(label: 'ThemeData original\n(azul)')),

          // Novo ThemeData que sobrescreve o inicial apenas nesta subárvore.
          Expanded(
            child: Theme(
              data: Theme.of(context).copyWith(
                scaffoldBackgroundColor: Colors.yellow,
              ),
              child: const ThemedBox(label: 'ThemeData sobrescrito\n(amarelo)'),
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget que lê a cor de background do tema mais próximo na árvore.
/// Por ser uma classe separada, ele recebe o `context` já com o Theme
/// sobrescrito quando está dentro do widget `Theme(...)`.
class ThemedBox extends StatelessWidget {
  const ThemedBox({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: theme.scaffoldBackgroundColor,
      alignment: Alignment.center,
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: theme.textTheme.titleMedium,
      ),
    );
  }
}
