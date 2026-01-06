import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hello_world/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Berkays App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 83, 6, 99),
        ),
      ),
      home: LoginPage(),
    );
  }
}
