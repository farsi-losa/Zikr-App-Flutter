import 'package:flutter/material.dart';
import 'package:dzikirapp/db.dart';
import 'package:dzikirapp/component/listView.dart';
import 'package:dzikirapp/component/listViewDefault.dart';
import 'package:dzikirapp/component/route.dart';
import 'package:dzikirapp/models/globalCounter.dart';
import 'package:provider/provider.dart';
import 'package:flutter/rendering.dart';

class AppHome extends StatefulWidget {
  AppHome({Key? key}) : super(key: key);
  @override
  _AppHome createState() => _AppHome();
}

class _AppHome extends State<AppHome> with TickerProviderStateMixin {
  // This widget is the root of your application.
  late ScrollController scrollcontroller = new ScrollController();
  late DatabaseHandler handler;
  late AnimationController modalController;

  bool openAction = false;
  bool isScrollingDown = false;

  bool scrollVisibility = true;

  void onTapOptionItem() {
    setState(() {
      openAction = !openAction;
    });
  }

  @override
  void initState() {
    super.initState();
    this.handler = DatabaseHandler();

    scrollcontroller.addListener(() {
      if (scrollcontroller.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (!isScrollingDown) {
          setState(() {
            isScrollingDown = true;
            scrollVisibility = false;
          });
        }
      }

      if (scrollcontroller.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (isScrollingDown) {
          setState(() {
            isScrollingDown = false;
            scrollVisibility = true;
          });
        }
      }

      setState(() {});
    });

    initController();
  }

  void initController() {
    modalController = BottomSheet.createAnimationController(this);
    modalController.duration = Duration(milliseconds: 500);
    modalController.reverseDuration = const Duration(milliseconds: 100);
  }

  void _onItemClicked(data) {
    Navigator.of(context).push(createRoute(data)).then((value) {
      _onDataChange();
    });
  }

  void _onBarClick() {
    print('bar clicked');
    this.setState(() {
      scrollVisibility = !scrollVisibility;
    });
  }

  void _onDataChange() {
    this.setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    modalController.dispose();
    scrollcontroller.removeListener(() {});
    scrollcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var globalCounter = Provider.of<SettingsModel>(context);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Dzikir List',
            style: const TextStyle(color: Color(0xffAF9C4D)),
          ),
          elevation: 0,
          backgroundColor: Color(0xffE7EFEE),
        ),
        body: FutureBuilder(
          future: Future.wait([
            this.handler.retrieveDzikirsDefault(),
            this.handler.retrieveDzikirs(),
          ]),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.hasData) {
              return Container(
                color: Color(0xffE7EFEE),
                height: double.infinity,
                child: Column(children: [
                  Container(
                      child: globalCounter.dzikirReference
                          ? AnimatedContainer(
                              height: scrollVisibility ? 180.0 : 0.0,
                              duration: Duration(milliseconds: 400),
                              child: Stack(children: <Widget>[
                                Positioned(
                                  height: 160.0,
                                  left: 15.0,
                                  right: 15.0,
                                  top: 15.0,
                                  // bottom: 40.0,
                                  child: SizedBox(
                                    // height: 160.0,
                                    width: double.infinity,
                                    child: dzikirDefaultListView(
                                        snapshot.data![0],
                                        _onDataChange,
                                        _onItemClicked),
                                  ),
                                ),
                              ]),
                            )
                          : null),
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(top: 40),
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.only(
                            topRight: Radius.circular(50)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.10),
                            spreadRadius: 0,
                            blurRadius: 30,
                            offset: Offset(0, -5), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(children: [
                        GestureDetector(
                          onTap: () {
                            _onBarClick();
                          },
                          child: Container(
                            padding: EdgeInsets.only(top: 20, bottom: 20),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(50),
                              ),
                            ),
                            child: Center(
                              child: Container(
                                width: 68,
                                height: 4,
                                decoration: BoxDecoration(
                                  color: Color(0xffE7EFEE),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: DzikirListView(
                            data: snapshot.data![1],
                            onDataChange: _onDataChange,
                            onItemClicked: _onItemClicked,
                            scrollcontroller: scrollcontroller,
                          ),
                        ),
                      ]),
                    ),
                  ),
                ]),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
