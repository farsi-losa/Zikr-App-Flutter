import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:dzikirapp/component/route.dart';
import 'package:dzikirapp/db.dart';

class DzikirCounter extends StatefulWidget {
  final int timer;
  final int qty;
  final String name;
  final int lastCount;
  final int id;
  final String dzikirType;

  DzikirCounter(
      {Key? key,
      required this.id,
      required this.timer,
      required this.name,
      required this.qty,
      required this.lastCount,
      required this.dzikirType})
      : super(key: key);

  @override
  _DzikirCounterState createState() => _DzikirCounterState();
}

class _DzikirCounterState extends State<DzikirCounter>
    with SingleTickerProviderStateMixin {
  late DatabaseHandler handler;
  late TabController _tabController;
  late int _qtyZikr;
  late String _dzikirName;
  late int _timerLength;
  late Timer _timerZikr;
  late bool _timerActive;
  late int _id;
  late int _counter;

  int _currentIndex = 0;
  bool _isPlaying = false;
  bool _vibrateOnTap = true;

  void initState() {
    super.initState();

    this.handler = DatabaseHandler();
    _timerActive = false;
    _counter = widget.lastCount;
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
    _timerLength = widget.timer;
    _dzikirName = widget.name;
    _qtyZikr = widget.qty;
    _id = widget.id;
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging && _isPlaying) {
      _zikrStop();
    }
    setState(() {
      _currentIndex = _tabController.index;
    });
  }

  void _playZikr() {
    setState(() {
      _timerActive = true;
    });
    _timerZikr = Timer.periodic(Duration(milliseconds: _timerLength), (timer) {
      Vibrate.feedback(FeedbackType.success);
      setState(() {
        _counter++;
      });
      if (_counter == _qtyZikr) {
        Vibrate.vibrate();
        _zikrStop();
      }
    });

    setState(() {
      _isPlaying = true;
    });
  }

  void _zikrStop() {
    _timerZikr.cancel();
    setState(() {
      _isPlaying = false;
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
      // _countLoop = 1;
    });
  }

  void _toggleVibrateOnTap() {
    setState(() {
      _vibrateOnTap = !_vibrateOnTap;
    });
  }

  void _countingZikr() async {
    if (_qtyZikr != 0 && _counter < _qtyZikr) {
      setState(() {
        _counter++;
      });
    } else if (_qtyZikr == 0) {
      setState(() {
        _counter++;
      });
    }

    if (_qtyZikr == _counter) {
      Vibrate.vibrate();
    } else {
      if (_vibrateOnTap) {
        Vibrate.feedback(FeedbackType.success);
      }
    }
  }

  Future<int> updateDzikirs(id) async {
    Dzikir dzikir = Dzikir(
        id: id,
        name: _dzikirName,
        qty: _qtyZikr,
        timer: _timerLength,
        lastcount: _counter);
    return await this.handler.updateDzikir(dzikir, widget.dzikirType);
  }

  @override
  void dispose() {
    super.dispose();
    if (_timerActive) {
      _timerZikr.cancel();
    }
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        updateDzikirs(_id);
        return true;
      },
      child: new Scaffold(
        appBar: AppBar(
          leading: new IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () {
                updateDzikirs(_id);
                Navigator.of(context).pop(createRouteToHome);
              }),
          title: Text(
            '$_dzikirName',
            style: TextStyle(color: Color(0xff93BC9C)),
          ),
          iconTheme: IconThemeData(color: Color(0xff93BC9C)),
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: Container(
          decoration: BoxDecoration(color: Color(0xffE8F0EF)),
          child: Stack(children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                width: 100,
                height: 450,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.20),
                      spreadRadius: 0,
                      blurRadius: 14,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                // tab bar view here
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 40, bottom: 70),
                        child: Center(
                          child: Text(
                            _counter.toString(),
                            style: TextStyle(
                                color: Color(0xff2F6149), fontSize: 80),
                          ),
                        ),
                      ),
                      // Container(
                      //   margin: const EdgeInsets.only(top: 40, bottom: 70),
                      //   child: Center(
                      //     child: FutureBuilder(
                      //         future: this.handler.retrieveDzikir(_id),
                      //         builder: (BuildContext context,
                      //             AsyncSnapshot<List<Dzikir>> snapshot) {
                      //           if (snapshot.hasData) {
                      //             return Text(
                      //               _counter.toString(),
                      //               style: TextStyle(
                      //                   color: Color(0xff2F6149), fontSize: 80),
                      //             );
                      //           } else {
                      //             return Text(
                      //               _counter.toString(),
                      //               style: TextStyle(
                      //                   color: Color(0xff2F6149), fontSize: 80),
                      //             );
                      //           }
                      //         }),
                      //   ),
                      // ),
                      AnimatedContainer(
                        // Define how long the animation should take.
                        duration: const Duration(seconds: 1),
                        // Provide an optional curve to make the animation feel smoother.
                        curve: Curves.fastOutSlowIn,
                        // margin: const EdgeInsets.fromLTRB(35, 0, 35, 55),
                        width: _currentIndex == 0 ? 340 : 300,
                        height: 62,
                        padding: const EdgeInsets.only(bottom: 10, top: 10),
                        margin: const EdgeInsets.only(bottom: 34),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Row(children: [
                                Spacer(),
                                Align(
                                  alignment: Alignment(0, 0.15),
                                  child: Text(
                                    'Target',
                                    style: TextStyle(
                                        color: Color(0xff93BC9C), fontSize: 12),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: Text(
                                    _qtyZikr.toString(),
                                    style: TextStyle(
                                        color: Color(0xff93BC9C), fontSize: 25),
                                  ),
                                ),
                                Spacer(),
                              ]),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    left: BorderSide(
                                        width: 1.0, color: Color(0xffE7EFEE)),
                                    right: BorderSide(
                                        width: 1.0, color: Color(0xffE7EFEE)),
                                  ),
                                ),
                                child: AnimatedSwitcher(
                                  duration: Duration(milliseconds: 400),
                                  child: _currentIndex == 0
                                      ? Container(
                                          color: Colors.white,
                                          child: Row(children: [
                                            Spacer(),
                                            Column(children: [
                                              Icon(Icons.timer,
                                                  color: Color(0xff93BC9C)),
                                              Text(
                                                'ms',
                                                style: TextStyle(
                                                    color: Color(0xff93BC9C),
                                                    fontSize: 12),
                                              ),
                                            ]),
                                            Text(
                                              '$_timerLength',
                                              style: TextStyle(
                                                  color: Color(0xff93BC9C),
                                                  fontSize: 25),
                                            ),
                                            Spacer(),
                                          ]),
                                        )
                                      : GestureDetector(
                                          onTap: () {
                                            _toggleVibrateOnTap();
                                          },
                                          child: Container(
                                            color: Colors.white,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8),
                                            child: Center(
                                              child: Icon(Icons.vibration_sharp,
                                                  color: _vibrateOnTap
                                                      ? Color(0xff93BC9C)
                                                      : Colors.grey),
                                            ),
                                          ),
                                        ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: InkWell(
                                onTap: _resetCounter,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Icon(Icons.loop_rounded,
                                      color: Color(0xff93BC9C)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.20),
                              spreadRadius: 0,
                              blurRadius: 14,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        child: Center(
                          child: Container(
                            width: 233,
                            height: 219,
                            child: Material(
                              color: Color(0xffAF9C4D),
                              borderRadius:
                                  new BorderRadius.all(Radius.circular(40)),
                              child: InkWell(
                                borderRadius:
                                    new BorderRadius.all(Radius.circular(40)),
                                onTap: (_currentIndex == 0
                                    ? _qtyZikr > 0 &&
                                            _timerLength > 0 &&
                                            _counter < _qtyZikr
                                        ? (_isPlaying ? _zikrStop : _playZikr)
                                        : () => null
                                    : _countingZikr),
                                child: AnimatedSwitcher(
                                  duration: Duration(milliseconds: 500),
                                  child: _currentIndex == 0
                                      ? Column(children: [
                                          Spacer(),
                                          Icon(
                                              _isPlaying
                                                  ? Icons.stop
                                                  : Icons.play_arrow,
                                              color: Colors.white,
                                              size: 100),
                                          Spacer(),
                                          Text(
                                            'click to start counting',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          Spacer(),
                                        ])
                                      : Column(children: [
                                          Spacer(),
                                          Container(
                                            width: 130,
                                            height: 130,
                                            child: Center(
                                              child: Container(
                                                width: 95,
                                                height: 95,
                                                child: Center(
                                                  child: Container(
                                                    width: 60,
                                                    height: 60,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  65)),
                                                      border: Border.all(
                                                          color:
                                                              Colors.white24),
                                                    ),
                                                  ),
                                                ),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(65)),
                                                  border: Border.all(
                                                      color: Colors.white30),
                                                ),
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(65)),
                                              border: Border.all(
                                                  color: Colors.white54),
                                            ),
                                          ),
                                          Spacer(),
                                          Text(
                                            'tap to counting',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          Spacer(),
                                        ]),
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xff8D8D8D).withOpacity(0.25),
                                  spreadRadius: 0,
                                  blurRadius: 20,
                                  offset: Offset(
                                      0, 5), // changes position of shadow
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Spacer()
                    ],
                  ),
                ),
                Container(
                  height: 54,
                  width: 250,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      15.0,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xffCACACA).withOpacity(0.20),
                        spreadRadius: 0,
                        blurRadius: 20,
                        offset: Offset(0, 0), // changes position of shadow
                      ),
                    ],
                  ),
                  child: TabBar(
                    controller: _tabController,
                    // give the indicator a decoration (color and border radius)
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        15.0,
                      ),
                      color: Color(0xff24573F),
                    ),

                    unselectedLabelColor: Color(0xff93BC9C),
                    tabs: [
                      Tab(
                        text: 'Automatic',
                      ),
                      Tab(
                        text: 'Manual',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
