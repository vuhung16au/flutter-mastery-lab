import 'package:flutter/material.dart';
import 'widgets/home_page.dart';

void main() {
  runApp(const FlutterWidgetsDemoApp());
}

// Main App - Demonstrates MaterialApp class
class FlutterWidgetsDemoApp extends StatelessWidget {
  const FlutterWidgetsDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sydney Widgets Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
