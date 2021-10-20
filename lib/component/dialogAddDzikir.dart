import 'package:flutter/material.dart';
import 'package:dzikirapp/db.dart';

class DialogAddDzikir extends StatefulWidget {
  final int qty;
  final int timer;
  final String? method;
  final String name;
  final int? id;
  final int lastCount;

  DialogAddDzikir(
      {Key? key,
      required this.qty,
      required this.timer,
      this.method,
      this.id,
      required this.name,
      required this.lastCount})
      : super(key: key);

  @override
  _DialogAddDzikirState createState() => new _DialogAddDzikirState();
}

class _DialogAddDzikirState extends State<DialogAddDzikir> {
  late int _qtyZikr;
  late String _nameDzikir;
  late TextEditingController txtQty;
  late TextEditingController txtName;
  late DateTime startDate;
  late DatabaseHandler handler;
  late bool _validateName = true;
  late bool _validateQty = true;
  late bool _validateTimer = true;
  late int _lastCount;

  bool _timerStart = false;

  int _timerLength = 0;

  @override
  void initState() {
    super.initState();
    _lastCount = widget.lastCount;
    _timerLength = widget.timer;
    _qtyZikr = widget.qty;
    _nameDzikir = widget.name;
    txtQty = TextEditingController(text: widget.qty.toString());
    txtName = TextEditingController(text: widget.name);

    this.handler = DatabaseHandler();
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

  void onSaveClick() {
    if (widget.method == 'add') {
      setState(() {
        _validateName = txtName.text.isNotEmpty;
        _validateQty = txtQty.text.isNotEmpty && txtQty.text != '0';
        _validateTimer = _timerLength != 0;
      });

      if (txtName.text.isNotEmpty &&
          txtQty.text.isNotEmpty &&
          txtQty.text != '0' &&
          _timerLength != 0) {
        this.addDzikir();
      }
    } else
      this.updateDzikirs(widget.id);
  }

  Future<int> addDzikir() async {
    Navigator.pop(context);
    Dzikir firstDzikir = Dzikir(
        name: _nameDzikir, qty: _qtyZikr, timer: _timerLength, lastcount: 0);
    List<Dzikir> listOfDzikirs = [firstDzikir];
    return await this.handler.insertDzikir(listOfDzikirs, 'dzikirs');
  }

  Future<int> updateDzikirs(id) async {
    Navigator.pop(context);
    Dzikir dzikir = Dzikir(
        id: id,
        name: _nameDzikir,
        qty: _qtyZikr,
        timer: _timerLength,
        lastcount: _lastCount);
    return await this.handler.updateDzikir(dzikir);
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      content: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
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
                padding: EdgeInsets.only(bottom: 20.0),
                child: TextField(
                  controller: txtName,
                  style: TextStyle(fontSize: 16.0, height: 1.5),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    errorText: _validateName ? null : 'Value can\'t be empty',
                    border: const OutlineInputBorder(),
                  ),
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
                padding: EdgeInsets.only(bottom: 20.0),
                child: TextField(
                  controller: txtQty,
                  style: TextStyle(fontSize: 16.0, height: 1.5),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    border: const OutlineInputBorder(),
                    errorText: _validateQty ? null : 'Value can\'t be empty',
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (text) {
                    _inputQtyChange(text.length > 0 ? int.parse(text) : 0);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Set Timer',
                  style: TextStyle(color: Color(0xff407C60)),
                ),
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
                        child: Text(_timerStart ? 'stop' : 'start'),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                alignment: Alignment.topLeft,
                child: _validateTimer
                    ? null
                    : Text(
                        "Value can't be zero",
                        style: TextStyle(fontSize: 12, color: Colors.red),
                        textAlign: TextAlign.left,
                      ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  '*please start then saying your dzikir and stop after finish',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Cancel',
            style: TextStyle(color: Color(0xffB64839), fontSize: 16),
          ),
        ),
        TextButton(
          onPressed: () => onSaveClick(),
          child: Text(
            'Save',
            style: TextStyle(color: Color(0xff407C60), fontSize: 16),
          ),
        ),
      ],
    );
  }
}
