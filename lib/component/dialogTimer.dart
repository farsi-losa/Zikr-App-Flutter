import 'package:flutter/material.dart';

class MyDialog extends StatefulWidget {
  final int timerLength;
  MyDialog({Key? key, required this.timerLength}) : super(key: key);
  @override
  _MyDialogState createState() => new _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  bool _timerStart = false;
  int _timerLength = 0;
  late DateTime startDate;
  // Do your operations
  // var endDate = new Date();
  // var seconds = (endDate.getTime() - startDate.getTime()) / 1000;
  @override
  void initState() {
    super.initState();

    _timerLength = widget.timerLength;
  }

  void _handleTimerCLick() {
    if (_timerStart) {
      var endDate = new DateTime.now();
      var seconds = endDate.difference(startDate).inMilliseconds;
      print(seconds);

      setState(() {
        _timerStart = false;
        _timerLength = seconds;
      });
    } else {
      startDate = new DateTime.now();
      setState(() {
        _timerStart = true;
      });
    }
  }

  void _resetTimer() {
    setState(() {
      _timerLength = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Set Timer'),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: _timerStart
                        ? Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Color(0xff93BC9C),
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(0xff24573F)),
                            ),
                          )
                        : Text('$_timerLength ms'),
                  ),
                  Expanded(
                    child: (_timerLength > 0 && !_timerStart)
                        ? TextButton(
                            onPressed: _resetTimer,
                            child: Icon(Icons.loop_rounded,
                                color: Color(0xff93BC9C)),
                          )
                        : SizedBox(),
                  ),
                  Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xff93BC9C)),
                        onPressed: _handleTimerCLick,
                        child: Text(_timerStart ? 'stop' : 'start')),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                  '*please start then saying your dzikir and stop after finish'),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Cancel',
            style: TextStyle(color: Color(0xffB64839)),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, _timerLength),
          child: Text(
            'Save',
            style: TextStyle(color: Color(0xff407C60)),
          ),
        ),
      ],
    );
  }
}
