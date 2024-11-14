import 'package:flutter/material.dart';
import 'package:nikkle/pages/checkout.dart';
import 'package:nikkle/pages/home.dart';
import 'package:nikkle/pages/index.dart';
import 'package:nikkle/pages/login.dart';
import 'package:nikkle/pages/splash.dart';
import 'package:nikkle/services/cart_provider.dart';
import 'package:nikkle/utils/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const SplashScreen(),
        routes: {
          '/login': (context) => const LoginScreen(),
          '/home': (context) => const HomePage(),
          '/dashboard': (context) => const DashboardPage(),
          '/cart': (context) => const CartScreen(),
        },
      ),
    );
  }
}
