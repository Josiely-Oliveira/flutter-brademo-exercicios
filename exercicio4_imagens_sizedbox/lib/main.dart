import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercício 4 - Imagens e SizedBox',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // URLs de exemplo (imagens livres de direitos, do Unsplash source).
  // Troque pelas imagens que preferir.
  static const String urlImagemGrande =
      'https://picsum.photos/id/1015/800/500'; // paisagem
  static const String urlImagemPequena =
      'https://picsum.photos/id/1025/800/500'; // outra foto

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Insert Image Example')),
      body: SingleChildScrollView(
        // SingleChildScrollView evita overflow caso a tela seja pequena.
        child: Column(
          children: [
            // Imagem 1 (maior) 
            SizedBox(
              width: double.infinity,
              height: 220,
              child: FittedBox(
                // FittedBox redimensiona o filho para caber na área
                // definida pelo SizedBox, mantendo a proporção.
                fit: BoxFit.cover,
                child: Image.network(urlImagemGrande),
              ),
            ),

            // Espaçador 
            // SizedBox usado apenas para criar um espaço vertical
            // entre as duas imagens (como uma "div" vazia).
            const SizedBox(height: 24),

            // Imagem 2 (menor) 
            SizedBox(
              width: double.infinity,
              height: 140,
              child: FittedBox(
                fit: BoxFit.cover,
                child: Image.network(urlImagemPequena),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
