import 'package:flutter/material.dart';
import 'package:dzikirapp/db.dart';

class DialogAddDzikir extends StatefulWidget {
  // final int qty;
  // final int timerLength;

  DialogAddDzikir({
    Key? key,
    // required this.timerLength,
    // required this.qty,
  }) : super(key: key);
  @override
  _DialogAddDzikirState createState() => new _DialogAddDzikirState();
}

class _DialogAddDzikirState extends State<DialogAddDzikir> {
  int _qtyZikr = 0;
  late String _nameDzikir;
  late TextEditingController txtQty;
  late TextEditingController txtName;
  bool _timerStart = false;
  int _timerLength = 0;
  late DateTime startDate;
  late DatabaseHandler handler;
  @override
  void initState() {
    super.initState();

    // _timerLength = widget.timerLength;
    // _qtyZikr = widget.qty;
    txtQty = TextEditingController();
    txtName = TextEditingController();

    this.handler = DatabaseHandler();
    // this.handler.initializeDB().whenComplete(() async {
    //   // await this.addUsers();
    //   setState(() {});
    // });
  }

  void _inputQtyChange(value) {
    setState(() {
      _qtyZikr = value;
    });
  }

  void _inputNameChange(value) {
    setState(() {
      _nameDzikir = value;
    });
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

  Future<int> addUsers() async {
    Navigator.pop(context);
    Dzikir firstDzikir =
        Dzikir(name: _nameDzikir, qty: _qtyZikr, timer: _timerLength);
    List<Dzikir> listOfDzikirs = [firstDzikir];
    return await this.handler.insertUser(listOfDzikirs);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Dzikir name',
              style: TextStyle(color: Color(0xff407C60)),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(2.0),
            child: TextField(
              controller: txtName,
              onChanged: (text) {
                _inputNameChange(text);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(2.0),
            child: Text(
              'Dzikir quantity',
              style: TextStyle(color: Color(0xff407C60)),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: txtQty,
              keyboardType: TextInputType.number,
              onChanged: (text) {
                _inputQtyChange(text.length > 0 ? int.parse(text) : 0);
              },
            ),
          ),
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
                      style:
                          ElevatedButton.styleFrom(primary: Color(0xff93BC9C)),
                      onPressed: _handleTimerCLick,
                      child: Text(_timerStart ? 'stop' : 'start')),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              '*please start then saying your dzikir and stop after finish',
              style: TextStyle(fontSize: 12),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Color(0xffB64839)),
                  ),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () => this.addUsers(),
                  child: Text(
                    'Save',
                    style: TextStyle(color: Color(0xff407C60)),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
