import 'package:flutter/material.dart';

void main() => runApp(const Exercicio6App());

class Exercicio6App extends StatelessWidget {
  const Exercicio6App({super.key});

  @override
  Widget build(BuildContext context) {
    // Raiz da árvore: MaterialApp + Scaffold (dentro de TarefasPage).
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notas de Tarefas',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),
      home: const TarefasPage(),
    );
  }
}

class Tarefa {
  final String titulo;
  bool concluida;

  Tarefa(this.titulo, {this.concluida = false});
}

class TarefasPage extends StatefulWidget {
  const TarefasPage({super.key});

  @override
  State<TarefasPage> createState() => _TarefasPageState();
}

class _TarefasPageState extends State<TarefasPage> {
  // 5 tarefas iniciais, com a data/hora de criação no título.
  final List<Tarefa> _tarefas = List.generate(
    5,
    (i) => Tarefa('Task ${DateTime.now().add(Duration(seconds: i))}'),
  );

  // false = mostrando pendentes; true = mostrando concluídas.
  bool _verConcluidas = false;

  void _mostrarDialogo() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Aviso'),
        content: const Text('Você está no App de Notas de Tarefas'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final visiveis = _tarefas.where((t) => t.concluida == _verConcluidas).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Notas de Tarefas')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () => setState(() => _verConcluidas = !_verConcluidas),
              child: Text(_verConcluidas ? 'Ver tarefas pendentes' : 'Ver tarefas concluídas'),
            ),
            const SizedBox(height: 12),
            Text(
              _verConcluidas
                  ? 'Você tem ${visiveis.length} tarefas concluídas'
                  : 'Você tem ${visiveis.length} tarefas pendentes',
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: visiveis.length,
                itemBuilder: (context, index) {
                  final tarefa = visiveis[index];
                  return Card(
                    color: Colors.amber.shade300,
                    child: ListTile(
                      title: Text(tarefa.titulo),
                      trailing: Checkbox(
                        value: tarefa.concluida,
                        onChanged: (valor) => setState(() => tarefa.concluida = valor ?? false),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _mostrarDialogo,
        child: const Icon(Icons.add),
      ),
    );
  }
}
