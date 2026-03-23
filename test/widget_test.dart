import 'package:auxistra/main.dart';
import 'package:auxistra/providers/music_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> pumpAuxistraApp(
  WidgetTester tester, {
  required bool isLoggedIn,
}) async {
  SharedPreferences.setMockInitialValues({
    'isLoggedIn': isLoggedIn,
  });
  final prefs = await SharedPreferences.getInstance();

  await tester.pumpWidget(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MusicProvider()),
        Provider<SharedPreferences>.value(value: prefs),
      ],
      child: AuxistraApp(prefs: prefs),
    ),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Auxistra app shell', () {
    testWidgets('shows auth screen after splash when user is logged out', (
      WidgetTester tester,
    ) async {
      await pumpAuxistraApp(tester, isLoggedIn: false);

      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.text('Sign In'), findsNothing);

      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();

      expect(find.text('Sign In'), findsOneWidget);
      expect(find.text('Access your music and mixes'), findsOneWidget);
      expect(find.widgetWithText(ElevatedButton, 'Sign In'), findsOneWidget);
    });

    testWidgets('shows main screen after splash when user is logged in', (
      WidgetTester tester,
    ) async {
      await pumpAuxistraApp(tester, isLoggedIn: true);

      expect(find.byType(MaterialApp), findsOneWidget);

      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();

      expect(find.byType(Scaffold), findsWidgets);
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Search'), findsOneWidget);
      expect(find.text('Library'), findsOneWidget);
      expect(find.text('Artist'), findsOneWidget);
      expect(find.byIcon(Icons.home_filled), findsOneWidget);
      expect(find.byIcon(Icons.search_rounded), findsOneWidget);
    });
  });
}
