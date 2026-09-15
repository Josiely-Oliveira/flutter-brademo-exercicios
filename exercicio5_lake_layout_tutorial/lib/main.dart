import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter layout demo',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter layout demo')),
        // ListView permite rolar a tela caso o conteúdo seja maior
        // que a altura disponível (equivalente a uma Column com scroll).
        body: ListView(
          children: const [
            ImageSection(
              image: 'https://picsum.photos/id/1015/800/500',
            ),
            TitleSection(
              name: 'Oeschinen Lake Campground',
              location: 'Kandersteg, Switzerland',
            ),
            ButtonSection(),
            TextSection(
              description:
                  'Lake Oeschinen lies at the foot of the Bluemlisalp in '
                  'the Bernese Alps. Situated 1,578 meters above sea '
                  'level, it is one of the larger Alpine Lakes. A gondola '
                  'ride from Kandersteg, followed by a half-hour walk '
                  'through pastures and pine forest, leads you to the '
                  'lake, which warms to 20 degrees Celsius in the '
                  'summer. Activities enjoyed here include rowing, and '
                  'riding the summer toboggan run.',
            ),
          ],
        ),
      ),
    );
  }
}

// Seção 1: Imagem de capa no topo da tela.
class ImageSection extends StatelessWidget {
  final String image;

  const ImageSection({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      image,
      width: double.infinity,
      height: 240,
      fit: BoxFit.cover, // preenche a largura mantendo a proporção
    );
  }
}

// Seção 2: Título (nome + localização) e avaliação (estrela + nota).
class TitleSection extends StatelessWidget {
  final String name;
  final String location;

  const TitleSection({
    super.key,
    required this.name,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Expanded faz esse bloco ocupar todo o espaço restante da
          // Row, empurrando a estrela + nota para a direita.
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    location,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.star, color: Colors.red),
          const Text('41'),
        ],
      ),
    );
  }
}

// Seção 3: Linha de botões (Call, Route, Share), reaproveitando a
class ButtonSection extends StatelessWidget {
  const ButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _ButtonWithText(color: color, icon: Icons.call, label: 'CALL'),
          _ButtonWithText(color: color, icon: Icons.near_me, label: 'ROUTE'),
          _ButtonWithText(color: color, icon: Icons.share, label: 'SHARE'),
        ],
      ),
    );
  }
}

class _ButtonWithText extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String label;

  const _ButtonWithText({
    required this.color,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}

// Seção 4: Texto de descrição do local.
class TextSection extends StatelessWidget {
  final String description;

  const TextSection({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        description,
        softWrap: true, // quebra linha automaticamente
      ),
    );
  }
}
