import 'package:flutter/material.dart';

class DialogQtyZikr extends StatefulWidget {
  final int qty;
  DialogQtyZikr({Key? key, required this.qty}) : super(key: key);

  @override
  _DialogZikrQty createState() => new _DialogZikrQty();
}

class _DialogZikrQty extends State<DialogQtyZikr> {
  int _qtyZikr = 0;
  late TextEditingController txtQty;

  @override
  void initState() {
    super.initState();

    _qtyZikr = widget.qty;
    txtQty = TextEditingController(text: widget.qty.toString());
  }

  void _inputQtyChange(value) {
    setState(() {
      _qtyZikr = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
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
              // inputFormatters: <TextInputFormatter>[
              //   FilteringTextInputFormatter.digitsOnly
              // ],
              onChanged: (text) {
                _inputQtyChange(text.length > 0 ? int.parse(text) : 0);
              },
            ),
          ),
        ],
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
          onPressed: () =>
              _qtyZikr.bitLength > 0 ? Navigator.pop(context, _qtyZikr) : {},
          child: Text(
            'Save',
            style: TextStyle(
                color:
                    _qtyZikr.bitLength > 0 ? Color(0xff407C60) : Colors.grey),
          ),
        ),
      ],
    );
  }
}
