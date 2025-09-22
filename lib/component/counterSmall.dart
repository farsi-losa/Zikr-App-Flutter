import 'package:flutter/material.dart';
import 'dart:async';

import 'package:vibration/vibration.dart';
import 'package:vibration/vibration_presets.dart';

class CounterSmall extends StatefulWidget {
  final int timer;
  final int qty;

  CounterSmall({
    Key? key,
    required this.timer,
    required this.qty,
  }) : super(key: key);

  @override
  _CounterSmallState createState() => _CounterSmallState();
}

class _CounterSmallState extends State<CounterSmall>
    with SingleTickerProviderStateMixin {
  late int _qtyZikr;
  late int _timerLength;
  late Timer _timerZikr;
  late bool _timerActive;
  late int _counter;

  bool _isPlaying = false;

  void initState() {
    super.initState();

    _timerActive = false;
    _timerLength = widget.timer;
    _qtyZikr = widget.qty;
    _counter = 0;
  }

  void _playZikr() {
    setState(() {
      _timerActive = true;
    });
    _timerZikr = Timer.periodic(Duration(milliseconds: _timerLength), (timer) {
      Vibration.vibrate(preset: VibrationPreset.singleShortBuzz);
      setState(() {
        _counter++;
      });
      if (_counter == _qtyZikr) {
        Vibration.vibrate(preset: VibrationPreset.longAlarmBuzz);
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

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      foregroundColor: Color(0xff24573F),
      backgroundColor: Color(0xffC8DDD0),
      padding: EdgeInsets.all(10),
      shape: const CircleBorder());

  @override
  void dispose() {
    super.dispose();
    if (_timerActive) {
      _timerZikr.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color(0xffE8F0EF)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "Hitung $_counter / $_qtyZikr",
            style: TextStyle(
              fontSize: 18,
              color: Color(0xff24573F),
              fontWeight: FontWeight.w400,
            ),
          ),
          Row(children: [
            ElevatedButton(
              style: raisedButtonStyle,
              onPressed: _resetCounter,
              child: Icon(Icons.loop_rounded),
            ),
            ElevatedButton(
              style: raisedButtonStyle,
              onPressed: _isPlaying ? _zikrStop : _playZikr,
              child: Icon(_isPlaying ? Icons.stop : Icons.play_arrow),
            ),
          ])
        ],
      ),
    );
  }
}
