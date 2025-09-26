import 'package:dzikirapp/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:dzikirapp/pages/index.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:dzikirapp/models/settings.dart';
import 'firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    final String secretsKey = 'assets/secret.json';
    await SecretLoader(secretPath: secretsKey).load().then(
          (value) async => {
            await Firebase.initializeApp(
              name: 'DzikirApps',
              options: DefaultFirebaseOptions.currentPlatform,
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
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
        Locale('id', ''), // Indonesian, no country code
      ],
      home: AppIndex(),
    );
  }
}
