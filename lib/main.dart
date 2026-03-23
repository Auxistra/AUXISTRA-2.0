import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme/app_theme.dart';
import 'screens/splash_screen.dart';
import 'screens/auth_screen.dart';
import 'screens/main_screen.dart';
import 'providers/music_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MusicProvider()),
        Provider<SharedPreferences>.value(value: prefs),
      ],
      child: AuxistraApp(prefs: prefs),
    ),
  );
}

class AuxistraApp extends StatefulWidget {
  final SharedPreferences prefs;
  const AuxistraApp({super.key, required this.prefs});

  @override
  State<AuxistraApp> createState() => _AuxistraAppState();
}

class _AuxistraAppState extends State<AuxistraApp> {
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // Wait for 2 seconds to show Splash Screen
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() {
        _isInitialized = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Auxistra',
      theme: AppTheme.darkTheme,
      scrollBehavior: const _AppScrollBehavior(),
      home: _getHomeWidget(),
      routes: {
        '/auth': (context) => const AuthScreen(),
        '/main': (context) => const MainScreen(),
      },
    );
  }

  Widget _getHomeWidget() {
    if (!_isInitialized) {
      return const SplashScreen();
    }

    // Once initialized, check login status
    final bool isLoggedIn = widget.prefs.getBool('isLoggedIn') ?? false;
    return isLoggedIn ? const MainScreen() : const AuthScreen();
  }
}

class _AppScrollBehavior extends MaterialScrollBehavior {
  const _AppScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
        PointerDeviceKind.trackpad,
        PointerDeviceKind.unknown,
      };
}
