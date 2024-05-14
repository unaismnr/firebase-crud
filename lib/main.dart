import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crud/pages/home.dart';
import 'package:firebase_crud/utils/consts.dart';
import 'package:flutter/material.dart';

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
      title: 'Firebase Crud',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: kMainColor,
        ),
        useMaterial3: false,
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
