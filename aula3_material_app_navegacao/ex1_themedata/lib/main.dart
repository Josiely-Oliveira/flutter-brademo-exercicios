import 'package:flutter/material.dart';

void main() => runApp(const Exercicio1App());

class Exercicio1App extends StatelessWidget {
  const Exercicio1App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Exercício 1 - ThemeData',
      // ThemeData do MaterialApp: define o background azul para todo o app.
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Background azul definido no ThemeData'),
      ),
    );
  }
}
