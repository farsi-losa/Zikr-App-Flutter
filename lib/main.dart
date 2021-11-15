import 'package:flutter/material.dart';
import 'package:dzikirapp/db.dart';
import 'package:dzikirapp/pages/information.dart';
import 'package:provider/provider.dart';
import 'package:dzikirapp/models/settings.dart';
import 'package:dzikirapp/component/dialogAddDzikir.dart';
import 'package:dzikirapp/pages/home.dart';
import 'package:dzikirapp/pages/dzikir_custom.dart';
import 'package:dzikirapp/pages/dzikir_detail.dart';
// import 'package:provider/provider.dart';
// import 'package:dzikirapp/component/AnimatedBottomNav.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DzikirCustom(),
    );
  }
}
