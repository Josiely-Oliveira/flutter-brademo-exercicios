import 'package:flutter/material.dart';

void main() => runApp(const Exercicio5App());

class Exercicio5App extends StatelessWidget {
  const Exercicio5App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BottomAppBar with FAB',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),
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
  int _tab = 0;
  bool _fabAberto = false;

  void _mostrarMensagem(String texto) {
    setState(() => _fabAberto = false);
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(texto)));
  }

  Widget _tabButton(IconData icone, String rotulo, int indice) {
    final selecionado = _tab == indice;
    final cor = selecionado ? Colors.red : Colors.grey;
    return InkWell(
      onTap: () => setState(() => _tab = indice),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icone, color: cor),
            Text(rotulo, style: TextStyle(fontSize: 11, color: cor)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BottomAppBar with FAB')),
      body: Stack(
        children: [
          Center(
            child: Text('TAB: $_tab', style: const TextStyle(fontSize: 32)),
          ),
          // Opções que aparecem acima do FAB quando ele é selecionado.
          if (_fabAberto)
            Positioned(
              left: 0,
              right: 0,
              bottom: 40,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FloatingActionButton.small(
                    heroTag: 'msg',
                    backgroundColor: Colors.white,
                    onPressed: () => _mostrarMensagem('Nova mensagem'),
                    child: const Icon(Icons.message, color: Colors.blue),
                  ),
                  const SizedBox(height: 12),
                  FloatingActionButton.small(
                    heroTag: 'mail',
                    backgroundColor: Colors.white,
                    onPressed: () => _mostrarMensagem('Novo e-mail'),
                    child: const Icon(Icons.email, color: Colors.blue),
                  ),
                  const SizedBox(height: 12),
                  FloatingActionButton.small(
                    heroTag: 'call',
                    backgroundColor: Colors.white,
                    onPressed: () => _mostrarMensagem('Nova ligação'),
                    child: const Icon(Icons.phone, color: Colors.blue),
                  ),
                ],
              ),
            ),
        ],
      ),
      // FAB encaixado no meio da BottomAppBar.
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _fabAberto = !_fabAberto),
        child: Icon(_fabAberto ? Icons.close : Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        // Recorte circular para acomodar o FAB.
        shape: const CircularNotchedRectangle(),
        notchMargin: 6,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _tabButton(Icons.menu, 'This', 0),
            _tabButton(Icons.layers, 'Is', 1),
            const SizedBox(width: 48), // espaço reservado para o FAB
            _tabButton(Icons.dashboard, 'Bottom', 2),
            _tabButton(Icons.info, 'Bar', 3),
          ],
        ),
      ),
    );
  }
}
