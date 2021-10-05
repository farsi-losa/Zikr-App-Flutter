import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class StackOver extends StatefulWidget {
  final int timer;
  final int qty;
  final String name;
  StackOver(
      {Key? key, required this.timer, required this.name, required this.qty})
      : super(key: key);

  @override
  _StackOverState createState() => _StackOverState();
}

class _StackOverState extends State<StackOver>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late int _qtyZikr;
  late String _dzikirName;
  late int _timerLength;
  late Timer _timerZikr;

  int _counter = 0;
  int _loopLength = 33;
  int _currentIndex = 0;
  int _countLoop = 1;
  bool _isPlaying = false;
  bool _vibrateOnTap = true;

  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
    _timerLength = widget.timer;
    _dzikirName = widget.name;
    _qtyZikr = widget.qty;
  }

  void _handleTabSelection() {
    setState(() {
      _currentIndex = _tabController.index;
    });
  }

  void _playZikr() {
    _timerZikr = Timer.periodic(Duration(milliseconds: _timerLength), (timer) {
      if (_countLoop == _loopLength) {
        setState(() {
          _countLoop = 1;
        });
        Vibrate.vibrate();
      } else {
        Vibrate.feedback(FeedbackType.success);
        setState(() {
          _countLoop++;
        });
      }
      setState(() {
        _counter++;
      });
      print(_countLoop);
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
      _countLoop = 1;
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

    if (_countLoop == _loopLength || _qtyZikr == _counter) {
      setState(() {
        _countLoop = 1;
      });

      Vibrate.vibrate();
    } else {
      if (_vibrateOnTap) {
        Vibrate.feedback(FeedbackType.success);
      }
      setState(() {
        _countLoop++;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                    Flexible(
                      flex: 3,
                      child: Container(
                        child: Center(
                          child: Text(
                            _counter.toString(),
                            style: TextStyle(
                                color: Color(0xff2F6149), fontSize: 80),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(35, 0, 35, 55),
                      height: 62,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Center(
                              child: Row(children: [
                                Align(
                                  alignment: Alignment(0, 0.15),
                                  child: Text(
                                    'Max',
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
                              ]),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: (_currentIndex == 0
                                ? Row(children: [
                                    Icon(Icons.timer, color: Color(0xff93BC9C)),
                                    Padding(
                                      padding: EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        '$_timerLength',
                                        style: TextStyle(
                                            color: Color(0xff93BC9C),
                                            fontSize: 25),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment(0, 0.15),
                                      child: Text(
                                        'ms',
                                        style: TextStyle(
                                            color: Color(0xff93BC9C),
                                            fontSize: 15),
                                      ),
                                    ),
                                  ])
                                : GestureDetector(
                                    onTap: () {
                                      _toggleVibrateOnTap();
                                    },
                                    child: Container(
                                      width: 50,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Center(
                                        child: Icon(Icons.vibration_sharp,
                                            color: _vibrateOnTap
                                                ? Color(0xff93BC9C)
                                                : Colors.grey),
                                      ),
                                    ),
                                  )),
                          ),
                          InkWell(
                            onTap: _resetCounter,
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Icon(Icons.loop_rounded,
                                  color: Color(0xff93BC9C)),
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
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      child: Center(
                        child: GestureDetector(
                          onTap: (_currentIndex == 0
                              ? Feedback.wrapForTap(
                                  (_qtyZikr > 0 &&
                                          _timerLength > 0 &&
                                          _counter < _qtyZikr)
                                      ? (_isPlaying ? _zikrStop : _playZikr)
                                      : () => null,
                                  context)
                              : _countingZikr),
                          child: Container(
                            width: 233,
                            height: 219,
                            child: (_currentIndex == 0
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
                                      style: TextStyle(color: Colors.white),
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
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(65)),
                                                border: Border.all(
                                                    color: Colors.white24),
                                              ),
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(65)),
                                            border: Border.all(
                                                color: Colors.white30),
                                          ),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(65)),
                                        border:
                                            Border.all(color: Colors.white54),
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      'tap to counting',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Spacer(),
                                  ])),
                            decoration: BoxDecoration(
                              color: Color(0xff93BC9C),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
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
                    color: Color(0xffE8F0EF),
                  ),

                  labelColor: Color(0xff93BC9C),
                  unselectedLabelColor: Color(0xff93BC9C),
                  tabs: [
                    // first tab [you can add an icon using the icon property]
                    Tab(
                      text: 'Automatic',
                    ),

                    // second tab [you can add an icon using the icon property]
                    Tab(
                      text: 'Manual',
                    ),
                  ],
                ),
              ),
              // give the tab bar a height [can change hheight to preferred height]
            ],
          ),
        ]),
      ),
    );
  }
}
