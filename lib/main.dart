import 'package:accel_test/accel_xyz.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: .dark,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: .fromSeed(
          seedColor: Colors.deepPurpleAccent,
          brightness: .light,
        )
      ),

      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: .fromSeed(
          seedColor: Colors.deepPurpleAccent,
          brightness: .dark
        )
      ),

      home: AccelXyz(),
    );
  }
}