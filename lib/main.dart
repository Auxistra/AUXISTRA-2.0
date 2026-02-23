import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/auth_screen.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(const AuxistraApp());
}

class AuxistraApp extends StatelessWidget {
  const AuxistraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auxistra',
      theme: AppTheme.darkTheme,
      initialRoute: '/auth',
      routes: {
        '/auth': (context) => const AuthScreen(),
        '/main': (context) => const MainScreen(),
      },
    );
  }
}
