import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              _isLogin ? 'Sign In' : 'Sign Up',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/main');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(_isLogin ? 'Login' : 'Sign Up'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _isLogin = !_isLogin;
                });
              },
              child: Text(_isLogin ? 'Create an account' : 'Already have an account? Login'),
            ),
          ],
        ),
      ),
    );
  }
}
