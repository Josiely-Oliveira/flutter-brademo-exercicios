import 'package:flutter/material.dart';

import '../models/login.dart';
import '../screens/home_screen.dart';

/// Widget reutilizável com os inputs e o botão de login.
class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    final login = Login(
      username: _userController.text.trim(),
      password: _passwordController.text,
    );

    if (login.isValid) {
      // pushReplacement: o usuário não volta para o login com o botão "voltar".
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text('Falha no login: usuário ou senha incorretos.'),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: _userController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _passwordController,
          obscureText: true,
          onSubmitted: (_) => _submit(),
          decoration: const InputDecoration(
            labelText: 'Password',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 4),
        TextButton(
          onPressed: () {},
          child: const Text('Forgot Password'),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: _submit,
            child: const Text('Login'),
          ),
        ),
      ],
    );
  }
}
