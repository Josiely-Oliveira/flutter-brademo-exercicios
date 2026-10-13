import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter By Example')),
      body: const Center(child: FlutterLogo(size: 200)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.star),
      ),
    );
  }
}
