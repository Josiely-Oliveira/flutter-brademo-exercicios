import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Atividade 1 - Prática com async e await (codelab dart.dev/codelabs/async-await)
// ---------------------------------------------------------------------------

// Parte 1: chama a função assíncrona fetchRole() e retorna o papel do usuário.
Future<String> reportUserRole() async {
  final username = await fetchRole();
  return 'User role: $username';
}

// Parte 2: chama fetchLoginAmount() e retorna a quantidade de logins.
Future<String> reportLogins() async {
  final logins = await fetchLoginAmount();
  return 'Total number of logins: $logins';
}

// Funções fornecidas pelo exercício (simulam operações demoradas).
const _role = 'administrator';
const _logins = 42;
const _halfSecond = Duration(milliseconds: 500);

Future<String> fetchRole() => Future.delayed(_halfSecond, () => _role);
Future<int> fetchLoginAmount() => Future.delayed(_halfSecond, () => _logins);

// ---------------------------------------------------------------------------
// Interface Flutter
// ---------------------------------------------------------------------------
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Atividade 1 - async/await',
      theme: ThemeData(colorSchemeSeed: Colors.green, useMaterial3: true),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _part1;
  String? _part2;
  bool _loading = false;

  Future<void> _run() async {
    setState(() {
      _loading = true;
      _part1 = null;
      _part2 = null;
    });
    final r1 = await reportUserRole();
    final r2 = await reportLogins();
    // Só atualiza a tela se o widget ainda estiver montado.
    if (!mounted) return;
    setState(() {
      _part1 = r1;
      _part2 = r2;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Atividade 1 - async e await')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FilledButton(
              onPressed: _loading ? null : _run,
              child: const Text('Executar reportUserRole() e reportLogins()'),
            ),
            const SizedBox(height: 24),
            if (_loading) const Center(child: CircularProgressIndicator()),
            if (_part1 != null)
              Card(child: ListTile(title: const Text('Parte 1'), subtitle: Text(_part1!))),
            if (_part2 != null)
              Card(child: ListTile(title: const Text('Parte 2'), subtitle: Text(_part2!))),
          ],
        ),
      ),
    );
  }
}
