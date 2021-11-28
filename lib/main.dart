import 'package:flutter/material.dart';
import 'dart:async';
import 'package:dzikirapp/pages/index.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyAHAsf51D0A407EklG1bs-5wA7EbyfNFg0',
      appId: 'dzikir-app',
      messagingSenderId: '448618578101',
      projectId: 'react-native-firebase-testing',
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dzikir app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AppIndex(),
    );
  }
}
