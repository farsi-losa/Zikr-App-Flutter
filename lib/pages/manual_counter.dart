import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:dzikirapp/component/dialogInputZikrLength.dart';

class ManualCounter extends StatefulWidget {
  ManualCounter({Key? key}) : super(key: key);
  @override
  _AutoCounterState createState() => _AutoCounterState();
}

class _AutoCounterState extends State<ManualCounter> {
  int _counter = 0;
  int _qtyZikr = 33;
  int _loopLength = 33;
  int _countLoop = 1;
  bool _vibrateOnTap = true;

  final Iterable<Duration> pauses = [
    const Duration(milliseconds: 100),
    const Duration(milliseconds: 100),
    const Duration(milliseconds: 100),
  ];

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

  void _showModal() {
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
                  'MANUAL COUNTER',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            Container(
              width: 240,
              height: 62,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      _showModal();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Center(
                        child: Row(children: [
                          Align(
                            alignment: Alignment(0, 0.18),
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
                      _toggleVibrateOnTap();
                    },
                    child: Container(
                      width: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Center(
                        child: Icon(Icons.vibration_sharp,
                            color: _vibrateOnTap ? Colors.white : Colors.grey),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _resetCounter();
                    },
                    child: Container(
                      width: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      height: 62,
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
                  onTap: _countingZikr,
                  child: Container(
                    width: 233,
                    height: 219,
                    child: Column(children: [
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
                                      BorderRadius.all(Radius.circular(65)),
                                  border: Border.all(color: Color(0xff327655)),
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(65)),
                              border: Border.all(color: Color(0xff327655)),
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(65)),
                          border: Border.all(color: Color(0xff327655)),
                        ),
                      ),
                      Spacer(),
                      Text(
                        'tap to counting',
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
                    icon: new Icon(Icons.arrow_back_ios, color: Colors.white),
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
