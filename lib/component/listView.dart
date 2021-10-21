import 'package:flutter/material.dart';
import 'package:dzikirapp/component/slideItem.dart';

// ListView dzikirListView(data, onDataChange, onItemClicked) {
// print(data);

class DzikirListView extends StatelessWidget {
  const DzikirListView(
      {Key? key,
      this.data,
      this.onDataChange,
      this.onItemClicked,
      this.scrollcontroller})
      : super(key: key);

  final data;
  final scrollcontroller;
  final onDataChange;
  final onItemClicked;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollcontroller,
      child: Column(
        children: <Widget>[
          Container(
            child: data.length == 0
                ? Column(
                    children: [
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 20),
                          width: 190,
                          height: 140,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image:
                                  AssetImage("assets/images/empty_dzikir.png"),
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 30, bottom: 10),
                        child: Text(
                          'Start by adding  a dzikir',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        width: 280,
                        child: Text(
                          'Click on the button at the bottom to add a new dzikir',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  )
                : ListView.builder(
                    itemCount: data.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      // return _tile(data[index].title, data[index].synopsis, data[index].type);
                      return Container(
                        margin: EdgeInsets.fromLTRB(30, 0, 30, 20),
                        child: SlideMenu(
                          onDataChange: onDataChange,
                          id: data![index].id!,
                          data: data![index],
                          dzikirType: 'custom',
                          child: Container(
                            child: new Material(
                              color: Colors.transparent,
                              child: InkWell(
                                splashColor: Color(0xffE8F0EF),
                                borderRadius: new BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  bottomLeft: Radius.circular(15),
                                ),
                                onTap: () {
                                  onItemClicked(data![index], 'custom');
                                },
                                child: Row(children: [
                                  Container(
                                    height: 50,
                                    width: 54,
                                    margin: EdgeInsets.all(10),
                                    child: Center(
                                      child: Text(
                                        (index + 1).toString(),
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ),
                                    decoration: new BoxDecoration(
                                      color: Color(0xff24573F),
                                      borderRadius: new BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 0, 0),
                                      child: Column(children: [
                                        Container(
                                          height: 24,
                                          width: double.infinity,
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            data![index].name.toUpperCase(),
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Color(0xff24573F),
                                                fontWeight: FontWeight.bold),
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                width: 1.0,
                                                color: Color(0xffE7EFEE),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 24,
                                          alignment: Alignment.centerRight,
                                          width: double.infinity,
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  child: Row(children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 4),
                                                      child: Text(
                                                        '${data![index].timer.toString()}',
                                                      ),
                                                    ),
                                                    Text(
                                                      'ms',
                                                    ),
                                                  ]),
                                                ),
                                                Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    '${data![index].lastcount.toString()} / ${data![index].qty.toString()} x',
                                                  ),
                                                ),
                                              ]),
                                        ),
                                      ]),
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
