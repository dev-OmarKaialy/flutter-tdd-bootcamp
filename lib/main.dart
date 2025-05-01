import 'package:flutter/material.dart';
import 'package:jokes_app/core/services/dependencies.dart';
import 'package:jokes_app/features/jokes/presentation/page/jokes_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependecy();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: JokePage(),
    );
  }
}
