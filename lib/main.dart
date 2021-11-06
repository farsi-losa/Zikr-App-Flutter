import 'package:flutter/material.dart';
import 'package:dzikirapp/db.dart';
import 'package:dzikirapp/pages/information.dart';
import 'package:provider/provider.dart';
import 'package:dzikirapp/models/settings.dart';
import 'package:dzikirapp/component/dialogAddDzikir.dart';
import 'package:dzikirapp/pages/home.dart';
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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
  }) : super(key: key);
  // final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late DatabaseHandler handler;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    this.handler = DatabaseHandler();
  }

  Widget getBody() {
    List<Widget> pages = [
      Container(child: AppHome()),
      Container(child: AppInformation()),
    ];
    return IndexedStack(
      index: _currentIndex,
      children: pages,
    );
  }

  // Widget _buildBottomBar() {
  //   return CustomAnimatedBottomBar(
  //     containerHeight: 70,
  //     backgroundColor: Color(0xff24573F),
  //     selectedIndex: _currentIndex,
  //     showElevation: false,
  //     itemCornerRadius: 24,
  //     curve: Curves.easeIn,
  //     onItemSelected: (index) => setState(() => _currentIndex = index),
  //     items: <BottomNavyBarItem>[
  //       BottomNavyBarItem(
  //         icon: Icon(Icons.list_outlined),
  //         title: Text('Dzikir'),
  //         activeColor: Colors.white,
  //         inactiveColor: Colors.white,
  //         textAlign: TextAlign.center,
  //       ),
  //       BottomNavyBarItem(
  //         icon: Icon(Icons.info_outline),
  //         title: Text('App info'),
  //         activeColor: Colors.white,
  //         inactiveColor: Colors.white,
  //         textAlign: TextAlign.center,
  //       ),
  //     ],
  //   );
  // }

  void _showAddDzikirModal() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogAddDzikir(
            method: 'add',
            name: '',
            qty: 0,
            timer: 0,
            lastCount: 0,
            dzikirType: 'custom');
      },
    ).then((value) {
      setState(() {});
    });
  }

  Widget _getFAB() {
    return FloatingActionButton(
      onPressed: () {
        _showAddDzikirModal();
      },
      child: Icon(Icons.add),
      backgroundColor: Color(0xff24573F),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SettingsModel()),
        FutureProvider<bool>(
          create: (context) => SettingsModel().fetchSetting,
          initialData: true,
        ),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: getBody(),
        floatingActionButton: _currentIndex == 0 ? _getFAB() : null,
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
        bottomNavigationBar: BottomAppBar(
          color: Color(0xff24573F),
          shape: AutomaticNotchedShape(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15))),
            RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.home),
                  color: _currentIndex == 0 ? Color(0xffAF9C4D) : Colors.white,
                  onPressed: () {
                    setState(() {
                      _currentIndex = 0;
                    });
                  }),
              IconButton(
                icon: Icon(Icons.info_outlined),
                color: _currentIndex == 1 ? Color(0xffAF9C4D) : Colors.white,
                onPressed: () {
                  setState(() {
                    _currentIndex = 1;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
