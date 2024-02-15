import 'package:flutter/material.dart';
import 'logic/page_logic.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final pageLogic = PageLogic();
  @override
  void initState() {
    pageLogic.splashing();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Text(
        "Splash Screen",
        style: TextStyle(fontSize: 30),
      ),
    ));
  }
}
