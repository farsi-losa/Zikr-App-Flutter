import 'package:flutter/material.dart';
import 'dart:async';
import 'package:dzikirapp/pages/index.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    name: 'DzikirApps',
    options: const FirebaseOptions(
      apiKey:
          'AAAAUtHohKQ:APA91bFYtyzr5LY-J04eoxVtCZ1KaG3XqZhvQ-xO6PnDWsHJJaT1FEkBZeu2qcjped2Oagza9DUrFkUexWT5ggnQyD5ppj4lKoHZO5DoIhguqHLj87lQ_BTfY2MTY4HVLJeAXSyZDV7Q',
      appId: '1:355708994724:android:d351638d0db00519205231',
      messagingSenderId: '355708994724',
      projectId: 'dzikir-app',
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  MyApp({Key? key}) : super(key: key);

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

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
