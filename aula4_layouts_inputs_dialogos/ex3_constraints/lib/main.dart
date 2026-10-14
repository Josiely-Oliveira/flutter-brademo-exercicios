import 'package:flutter/material.dart';

void main() => runApp(const Exercicio3App());

class Exercicio3App extends StatelessWidget {
  const Exercicio3App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Exercício 3 - Restrições de layout',
      theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal)),
      home: const ConstraintsPage(),
    );
  }
}

/// Regra do Flutter: "constraints descem, tamanhos sobem, o pai define a posição".
class ConstraintsPage extends StatelessWidget {
  const ConstraintsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Restrições de layout')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          const Text(
            'Constraints descem, tamanhos sobem, o pai define a posição.',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          // 1) Sem filhos e sem tamanho: o Container ocupa o máximo permitido.
          _Demo(
            titulo: '1. Container sem tamanho',
            descricao: 'Sem filho e sem tamanho, o Container ocupa todo o espaço que o pai permite.',
            child: Container(color: Colors.red.shade300),
          ),

          // 2) Restrição "tight": o filho é obrigado a ter o tamanho do pai.
          _Demo(
            titulo: '2. Restrições tight',
            descricao: 'O SizedBox 100x100 impõe tamanho exato. O Container pediu 200x200, mas é forçado a 100x100.',
            child: Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: 100,
                height: 100,
                child: Container(
                  width: 200,
                  height: 200,
                  color: Colors.orange.shade300,
                  alignment: Alignment.center,
                  child: const Text('pediu 200\nrecebeu 100'),
                ),
              ),
            ),
          ),

          // 3) Center "afrouxa" (loosen) a restrição: o filho escolhe seu tamanho.
          _Demo(
            titulo: '3. Center afrouxa a restrição',
            descricao: 'Com Center entre eles, o Container de 50x50 pode ter o tamanho que quiser (até 100x100).',
            child: Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: 100,
                height: 100,
                child: Center(
                  child: Container(
                    width: 50,
                    height: 50,
                    color: Colors.green.shade300,
                    alignment: Alignment.center,
                    child: const Text('50x50'),
                  ),
                ),
              ),
            ),
          ),

          // 4) ConstrainedBox: impõe restrições mínimas/máximas ao filho.
          _Demo(
            titulo: '4. ConstrainedBox (minWidth/minHeight)',
            descricao: 'O ConstrainedBox exige no mínimo 100x100. O Container pediu 40x40, então vira 100x100.',
            child: Align(
              alignment: Alignment.topLeft,
              child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 100, minHeight: 100),
                child: Container(
                  width: 40,
                  height: 40,
                  color: Colors.blue.shade300,
                  alignment: Alignment.center,
                  child: const Text('40x40\n→ 100x100'),
                ),
              ),
            ),
          ),

          // 5) Expanded/Flexible em um Row dividem o espaço por flex.
          _Demo(
            titulo: '5. Expanded em um Row',
            descricao: 'Dois Expanded dividem a largura na proporção 1:2 (flex).',
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(color: Colors.purple.shade200, alignment: Alignment.center, child: const Text('flex 1')),
                ),
                Expanded(
                  flex: 2,
                  child: Container(color: Colors.pink.shade200, alignment: Alignment.center, child: const Text('flex 2')),
                ),
              ],
            ),
          ),

          // 6) LayoutBuilder mostra as restrições recebidas.
          _Demo(
            titulo: '6. LayoutBuilder',
            descricao: 'Mostra as restrições que o pai está passando para este widget. Redimensione a janela!',
            child: LayoutBuilder(
              builder: (context, constraints) => Center(
                child: Text(
                  'minW=${constraints.minWidth.toStringAsFixed(0)}  maxW=${constraints.maxWidth.toStringAsFixed(0)}\n'
                  'minH=${constraints.minHeight.toStringAsFixed(0)}  maxH=${constraints.maxHeight.toStringAsFixed(0)}',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Cartão de demonstração: título, explicação e uma área cinza de 130 px de altura.
class _Demo extends StatelessWidget {
  const _Demo({required this.titulo, required this.descricao, required this.child});

  final String titulo;
  final String descricao;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(titulo, style: Theme.of(context).textTheme.titleMedium),
          Text(descricao, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 6),
          Container(
            height: 130,
            width: double.infinity,
            color: Colors.grey.shade300,
            child: child,
          ),
        ],
      ),
    );
  }
}
