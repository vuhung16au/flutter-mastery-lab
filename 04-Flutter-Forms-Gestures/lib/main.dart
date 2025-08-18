import 'package:flutter/material.dart';
import 'screens/home_page.dart';

void main() {
  runApp(const FormsGesturesApp());
}

class FormsGesturesApp extends StatelessWidget {
  const FormsGesturesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sydney Forms & Gestures Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
