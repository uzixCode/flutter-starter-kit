import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:starter_kit/src/routes/routes.dart';

void main() async {
  setupLocatorCore();
  locator.registerSingleton<GoRouter>(router);
  await locator.allReady();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Starter Kit',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
