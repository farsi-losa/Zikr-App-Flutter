import 'package:flutter/material.dart';
import 'package:dzikirapp/pages/auto_counter.dart';
import 'package:dzikirapp/pages/manual_counter.dart';
import 'package:dzikirapp/pages/information.dart';

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
      home: MyHomePage(title: 'Dzikir app'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _onMenuClicked(type) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => type == 'auto' ? AutoCounter() : ManualCounter(),
      ),
    );
  }

  void _onInformationClicked() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AppInformation(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bgpattern.png"),
            fit: BoxFit.contain,
            repeat: ImageRepeat.repeatY,
          ),
        ),
        child: Column(children: [
          Spacer(),
          GestureDetector(
            onTap: () {
              _onMenuClicked('auto');
            },
            child: Center(
              child: Container(
                height: 150,
                width: 150,
                alignment: Alignment.center,
                child: Text(
                  'Automatic counter',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
                decoration: BoxDecoration(
                  color: Color(0xff24573F),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: Offset(2, 2), // changes position of shadow
                    ),
                  ],
                ),
              ),
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              _onMenuClicked('manual');
            },
            child: Center(
              child: Container(
                height: 150,
                width: 150,
                alignment: Alignment.center,
                child: Text(
                  'Manual counter',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
                decoration: BoxDecoration(
                  color: Color(0xffAF9C4D),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: Offset(2, 2), // changes position of shadow
                    ),
                  ],
                ),
              ),
            ),
          ),
          Spacer(),
          Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
            child: GestureDetector(
              onTap: () {
                _onInformationClicked();
              },
              child: Text(
                'App Information',
                style: TextStyle(color: Color(0xff24573F), fontSize: 14),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
