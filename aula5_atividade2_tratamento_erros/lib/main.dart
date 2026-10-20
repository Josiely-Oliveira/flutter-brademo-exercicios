import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Atividade 2 - Tratamento de erros em operações assíncronas
// (codelab dart.dev/codelabs/async-await#exercise-practice-handling-errors)
// ---------------------------------------------------------------------------

// Chama fetchNewUsername() e retorna seu resultado.
// Se ocorrer qualquer erro, retorna a string do erro.
Future<String> changeUsername() async {
  try {
    return await fetchNewUsername();
  } catch (err) {
    return err.toString();
  }
}

// Fornecida pelo exercício: simula uma operação demorada que falha.
Future<String> fetchNewUsername() =>
    Future.delayed(const Duration(milliseconds: 500), () => throw UserError());

class UserError implements Exception {
  @override
  String toString() => 'New username is invalid';
}

// ---------------------------------------------------------------------------
// Interface Flutter
// ---------------------------------------------------------------------------
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Atividade 2 - Tratamento de erros',
      theme: ThemeData(colorSchemeSeed: Colors.orange, useMaterial3: true),
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
  String? _result;
  bool _loading = false;

  Future<void> _run() async {
    setState(() {
      _loading = true;
      _result = null;
    });
    final r = await changeUsername();
    if (!mounted) return;
    setState(() {
      _result = r;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Atividade 2 - Tratamento de erros')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FilledButton(
              onPressed: _loading ? null : _run,
              child: const Text('Executar changeUsername()'),
            ),
            const SizedBox(height: 24),
            if (_loading) const Center(child: CircularProgressIndicator()),
            if (_result != null)
              Card(
                child: ListTile(
                  leading: const Icon(Icons.error_outline),
                  title: const Text('Erro capturado e retornado como String'),
                  subtitle: Text(_result!),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
