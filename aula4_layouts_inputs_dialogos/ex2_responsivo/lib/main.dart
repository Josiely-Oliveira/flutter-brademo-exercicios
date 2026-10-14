import 'package:flutter/material.dart';

void main() => runApp(const Exercicio2App());

class Exercicio2App extends StatelessWidget {
  const Exercicio2App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Exercício 2 - Responsividade',
      theme: ThemeData.dark(useMaterial3: true),
      home: const ResponsivePage(),
    );
  }
}

const linguagens = ['Dart', 'JavaScript', 'PHP', 'C++'];

class ResponsivePage extends StatelessWidget {
  const ResponsivePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Responsive Layouts'), centerTitle: true),
      // OrientationBuilder reconstrói o layout quando a orientação muda.
      body: OrientationBuilder(
        builder: (context, orientation) {
          final paisagem = orientation == Orientation.landscape;

          if (paisagem) {
            // Paisagem: título/botões à esquerda, lista à direita.
            return Row(
              children: const [
                Expanded(child: _Cabecalho(paisagem: true)),
                VerticalDivider(width: 1),
                Expanded(child: _ListaLinguagens()),
              ],
            );
          }
          // Retrato: tudo em coluna.
          return const Column(
            children: [
              _Cabecalho(paisagem: false),
              Divider(height: 1),
              Expanded(child: _ListaLinguagens()),
            ],
          );
        },
      ),
    );
  }
}

class _Cabecalho extends StatelessWidget {
  const _Cabecalho({required this.paisagem});

  final bool paisagem;

  @override
  Widget build(BuildContext context) {
    final botoes = [
      ElevatedButton(onPressed: () {}, child: const Text('BUTTON 1')),
      ElevatedButton(onPressed: () {}, child: const Text('BUTTON 2')),
    ];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: paisagem ? MainAxisSize.max : MainAxisSize.min,
        children: [
          const Text('Cheetah Coding', style: TextStyle(fontSize: 26)),
          const SizedBox(height: 16),
          if (paisagem)
            Column(
              children: [
                botoes[0],
                const SizedBox(height: 12),
                botoes[1],
              ],
            )
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: botoes,
            ),
        ],
      ),
    );
  }
}

class _ListaLinguagens extends StatelessWidget {
  const _ListaLinguagens();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: linguagens.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) => SizedBox(
        height: 80,
        child: Center(
          child: Text(linguagens[index], style: const TextStyle(fontSize: 22)),
        ),
      ),
    );
  }
}
