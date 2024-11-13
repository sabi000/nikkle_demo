import 'package:flutter/material.dart';
import 'package:nikkle/pages/home.dart';
import 'package:nikkle/pages/login.dart';
import 'package:nikkle/pages/splash.dart';
import 'package:nikkle/utils/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
