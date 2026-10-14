import 'package:flutter/material.dart';

void main() => runApp(const Exercicio1App());

class Exercicio1App extends StatelessWidget {
  const Exercicio1App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Exercício 1 - GridView',
      theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)),
      home: const GaleriaPage(),
    );
  }
}

class Lugar {
  final String titulo;
  final String url;
  const Lugar(this.titulo, this.url);
}

// Imagens carregadas da internet com Image.network(url).
const lugares = <Lugar>[
  Lugar('Chennai\nFlower Market', 'https://picsum.photos/seed/flower/400/400'),
  Lugar('Tanjore\nBronze Works', 'https://picsum.photos/seed/bronze/400/400'),
  Lugar('Tanjore\nMarket', 'https://picsum.photos/seed/market/400/400'),
  Lugar('Tanjore\nThanjavur Temple', 'https://picsum.photos/seed/temple/400/400'),
  Lugar('Tanjore\nThanjavur Temple', 'https://picsum.photos/seed/tower/400/400'),
  Lugar('Pondicherry\nSalt Farm', 'https://picsum.photos/seed/salt/400/400'),
];

class GaleriaPage extends StatelessWidget {
  const GaleriaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GridView')),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        // 2 colunas, com espaçamento entre as células.
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemCount: lugares.length,
        itemBuilder: (context, index) {
          final lugar = lugares[index];
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: GridTile(
              // Legenda sobre a imagem, no rodapé de cada célula.
              footer: Container(
                color: Colors.black45,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: Text(
                  lugar.titulo,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
              child: Image.network(
                lugar.url,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.broken_image),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
