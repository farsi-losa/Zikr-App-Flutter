import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:dzikirapp/component/wrapperDzikir.dart';
// import 'package:package_info_plus/package_info_plus.dart';
// import 'package:dzikirapp/db.dart';
// import 'package:dzikirapp/models/settings.dart';
// import 'package:provider/provider.dart';
// import 'package:url_launcher/url_launcher.dart';

class DzikirDetail extends StatefulWidget {
  DzikirDetail({Key? key}) : super(key: key);
  @override
  _DzikirDetail createState() => _DzikirDetail();
}

class _DzikirDetail extends State<DzikirDetail>
    with SingleTickerProviderStateMixin {
  // This widget is the root of your application.

  List _items = [];
  late TabController _tabController;
  late int _activeTabIndex;

  @override
  void initState() {
    super.initState();
    _activeTabIndex = 0;
    readJson().then((result) {
      _tabController = new TabController(vsync: this, length: _items.length);
      void _setActiveTabIndex() {
        setState(() {
          _activeTabIndex = _tabController.index;
        });
      }

      _tabController.addListener(_setActiveTabIndex);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/dzikirpagi.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["items"];
    });
  }

  @override
  Widget build(BuildContext context) {
    String _dzikirLength = _items.length.toString();
    return MaterialApp(
      home: DefaultTabController(
        length: _items.length,
        child: Scaffold(
          appBar: AppBar(
            leading: new IconButton(
                icon: new Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            backgroundColor: Color(0xff93BC9C),
            elevation: 0,
            title: Text(
              'Dzikir Pagi',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          body: Column(children: [
            Flexible(
              child: Container(
                child: _items.isNotEmpty
                    ? TabBarView(
                        controller: _tabController,
                        children:
                            List<Widget>.generate(_items.length, (int index) {
                          print(_items[index]);
                          return WrapperDzikir(data: _items[index]);
                        }),
                      )
                    : Container(),
              ),
            ),
            Container(
              height: 60,
              width: double.infinity,
              color: Color(0xff24573F),
              child: Center(
                child: Text("${_activeTabIndex + 1} / $_dzikirLength",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
