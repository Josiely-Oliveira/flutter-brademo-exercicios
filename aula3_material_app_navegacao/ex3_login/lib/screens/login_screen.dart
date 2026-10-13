import 'package:flutter/material.dart';

import '../widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login Page')),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/logo.png',
                        height: 100,
                        // Se o asset não for encontrado, usa o logo do Flutter.
                        errorBuilder: (_, __, ___) => const FlutterLogo(
                          size: 100,
                          style: FlutterLogoStyle.horizontal,
                        ),
                      ),
                      const SizedBox(height: 32),
                      const LoginForm(),
                    ],
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('New User? Create Account'),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
