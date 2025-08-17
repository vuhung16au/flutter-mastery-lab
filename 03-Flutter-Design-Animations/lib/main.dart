import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/animated_splash_screen.dart';

void main() {
  runApp(const DesignAnimationsApp());
}

class DesignAnimationsApp extends StatelessWidget {
  const DesignAnimationsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sydney Design & Animations',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const AnimatedSplashScreen(),
    );
  }
}
