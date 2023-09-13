import 'package:dzikirapp/component/counterSmall.dart';
import 'package:dzikirapp/component/separator.dart';
import 'package:flutter/material.dart';

// ListView WrapperDzikir(data, onDataChange, onItemClicked) {
// print(data);

class WrapperDzikir extends StatelessWidget {
  const WrapperDzikir({
    Key? key,
    this.data,
  }) : super(key: key);

  final data;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffE8F0EF),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xff24573F),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                right: 20,
                top: 15,
                bottom: 15,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "${data["title"] != "-" ? data["title"] : ''}",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Dibaca ${data["qty"]}",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ]),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 40, left: 30, right: 30),
                      child: Text(
                        data["ayat"],
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontFamily: 'Trado',
                          fontSize: 35,
                          letterSpacing: 0.5,
                          height: 1.35,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                      child: const Separator(color: Color(0xff93BC9C)),
                    ),
                    data["counter"]
                        ? Column(children: [
                            CounterSmall(timer: data["timer"], qty: 100),
                            Container(
                              padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                              child: const Separator(color: Color(0xff93BC9C)),
                            )
                          ])
                        : Container(),
                    Container(
                      padding: EdgeInsets.fromLTRB(30, 10, 30, 40),
                      child: Text(
                        data["arti"],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          height: 1.4,
                          fontSize: 18,
                          color: Color(0xff24573F),
                        ),
                      ),
                    ),
                    Container(
                      child: data["benefit"] != "-"
                          ? Container(
                              padding: EdgeInsets.all(20),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 3,
                                    offset: Offset(
                                        2, 2), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                      bottom: 15,
                                    ),
                                    width: double.infinity,
                                    child: Text(
                                      'Faedah:',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Color(0xff24573F),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    data["benefit"],
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(color: Color(0xff24573F)),
                                  ),
                                ],
                              ),
                            )
                          : null,
                    ),
                    Container(
                        child: Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color(0xff93BC9C),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 3,
                            offset: Offset(2, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Container(
                        padding: EdgeInsets.only(
                          left: 10,
                        ),
                        width: double.infinity,
                        child: Text(
                          data["riwayat"],
                          style: TextStyle(color: Colors.white),
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              width: 10,
                              color: Color(0xffE7EFEE),
                            ),
                          ),
                        ),
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
