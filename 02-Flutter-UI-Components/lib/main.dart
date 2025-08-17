import 'package:flutter/material.dart';
import 'screens/home_page.dart';

void main() {
  runApp(const FlutterUIComponentsApp());
}

class FlutterUIComponentsApp extends StatelessWidget {
  const FlutterUIComponentsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sydney UI Components Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
