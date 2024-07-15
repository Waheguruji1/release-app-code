// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'user_onboarding.dart';
import 'main_page.dart';
import 'story_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final String? userName = prefs.getString('user_name');

  runApp(
    ProviderScope(
      child: MaterialApp(
        initialRoute: userName == null ? '/onboarding' : '/main',
        routes: {
          '/onboarding': (context) => UserOnboardingPage(),
          '/main': (context) => MainPage(),
        },
      ),
    ),
  );
}
