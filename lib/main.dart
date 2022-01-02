import 'package:flutter/material.dart';
import 'dart:async';
import 'package:dzikirapp/pages/index.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:dzikirapp/models/settings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    final String secretsKey = 'assets/secret.json';
    await SecretLoader(secretPath: secretsKey).load().then(
          (value) async => {
            await Firebase.initializeApp(
              name: 'DzikirApps',
              options: FirebaseOptions(
                apiKey: value.toString(),
                appId: '1:355708994724:android:d351638d0db00519205231',
                messagingSenderId: '355708994724',
                projectId: 'dzikir-app',
              ),
            )
          },
        );
  } on FirebaseException catch (e) {
    if (e.code == 'duplicate-app') {
      Firebase.app('DzikirApps');
    } else {
      throw e;
    }
  } catch (e) {
    rethrow;
  }

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
