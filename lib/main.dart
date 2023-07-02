import 'dart:core';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:marisanif21a/pages/awal.dart';
import 'package:marisanif21a/pages/login.dart';
import 'auth/firebase_options.dart';
 // Lakukan Comint Pada Sign UP dan LOgin kesluruhan Baik Itu Firebase Op
void main()  async {
  WidgetsFlutterBinding.ensureInitialized();
   Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Marisan',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: awal()
    );
  }
}

