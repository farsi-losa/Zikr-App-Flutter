import 'package:flutter/material.dart';
import 'dart:async';
import 'package:dzikirapp/component/dialogTimer.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:dzikirapp/component/dialogInputZikrLength.dart';

class AutoCounter extends StatefulWidget {
  AutoCounter({Key? key}) : super(key: key);

  @override
  _AutoCounterState createState() => _AutoCounterState();
}

class _AutoCounterState extends State<AutoCounter> {
  int _counter = 0;
  int _qtyZikr = 33;
  int _loopLength = 33;
  int _countLoop = 1;
  int _timerLength = 1100;
  bool _isPlaying = false;
  late Timer _timerZikr;

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

  void _showModal() {
    showDialog(
      context: context,
      builder: (context) => MyDialog(timerLength: _timerLength),
    ).then((value) {
      print(value);
      setState(() {
        _timerLength = value;
      });
    });
  }

  void _showQtyModal() {
    showDialog(
      context: context,
      builder: (context) => DialogQtyZikr(qty: _qtyZikr),
    ).then((value) {
      print(value);
      setState(() {
        _qtyZikr = value;
      });
    });
  }

  var txtQty = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bgcounter.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Flexible(
              flex: 3,
              child: Container(
                child: Center(
                  child: Text(
                    _counter.toString(),
                    style: TextStyle(color: Color(0xffE8F0EF), fontSize: 80),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 40),
              child: Center(
                child: Text(
                  'AUTOMATIC COUNTER',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(35, 0, 35, 55),
              height: 62,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      _showQtyModal();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Center(
                        child: Row(children: [
                          Align(
                            alignment: Alignment(0, 0.15),
                            child: Text(
                              'Max',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Text(
                              _qtyZikr.toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _showModal();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(children: [
                        Icon(Icons.timer, color: Colors.white),
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            '$_timerLength',
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ),
                        Align(
                          alignment: Alignment(0, 0.15),
                          child: Text(
                            'ms',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ]),
                    ),
                  ),
                  GestureDetector(
                    onTap: _resetCounter,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Icon(Icons.loop_rounded, color: Colors.white),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Color(0xff24573F),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            Flexible(
              flex: 3,
              child: Center(
                child: GestureDetector(
                  onTap: Feedback.wrapForTap(
                      (_qtyZikr > 0 && _timerLength > 0 && _counter < _qtyZikr)
                          ? (_isPlaying ? _zikrStop : _playZikr)
                          : () => null,
                      context),
                  child: Container(
                    width: 233,
                    height: 219,
                    child: Column(children: [
                      Spacer(),
                      Icon(_isPlaying ? Icons.stop : Icons.play_arrow,
                          color: Color(0xff93BC9C), size: 100),
                      Spacer(),
                      Text(
                        'click to start counting',
                        style: TextStyle(color: Color(0xff407C60)),
                      ),
                      Spacer(),
                    ]),
                    decoration: BoxDecoration(
                      color: Color(0xff24573F),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 82,
                height: 67,
                child: Align(
                  alignment: Alignment(0.5, 0),
                  child: IconButton(
                    icon: new Icon(Icons.arrow_back_ios,
                        color: Color(0xff93BC9C)),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color(0xff24573F),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(80)),
                ),
              ),
            )
          ],
        ),
      ),
      // floatingActionButton: InkWell(
      //   splashColor: Colors.blue,
      //   onLongPress: () {
      //     // handle your long press functionality here
      //     HapticFeedback.selectionClick();
      //   },
      //   child: FloatingActionButton(
      //     child: Icon(Icons.add),
      //     onPressed: () async {
      //       print('clicked');
      //       Feedback.wrapForTap(() => HapticFeedback.vibrate(), context);
      //     },
      //   ),
      // ),
    );
  }
}
