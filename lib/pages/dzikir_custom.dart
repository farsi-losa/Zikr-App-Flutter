import 'package:flutter/material.dart';
import 'package:dzikirapp/db.dart';
import 'package:provider/provider.dart';
import 'package:dzikirapp/models/settings.dart';
import 'package:dzikirapp/component/dialogAddDzikir.dart';
import 'package:dzikirapp/component/wrapperDzikirCustom.dart';

class DzikirCustom extends StatefulWidget {
  DzikirCustom({
    Key? key,
  }) : super(key: key);
  // final String title;

  @override
  _DzikirCustomState createState() => _DzikirCustomState();
}

class _DzikirCustomState extends State<DzikirCustom> {
  late DatabaseHandler handler;

  @override
  void initState() {
    super.initState();
    this.handler = DatabaseHandler();
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
      child: Icon(
        Icons.add,
        color: Colors.white,
      ),
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
        body: Container(child: WrapperDzikirCustom()),
        floatingActionButton: _getFAB(),
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
          child: Container(height: 50),
        ),
      ),
    );
  }
}
