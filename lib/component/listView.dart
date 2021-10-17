import 'package:flutter/material.dart';
import 'package:dzikirapp/component/slideItem.dart';

// ListView dzikirListView(data, onDataChange, onItemClicked) {
// print(data);

class DzikirListView extends StatelessWidget {
  const DzikirListView(
      {Key? key, this.data, this.onDataChange, this.onItemClicked})
      : super(key: key);

  final data;
  final onDataChange;
  final onItemClicked;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            child: ListView.builder(
              itemCount: data.length,
              // scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              // padding: const EdgeInsets.all(8),
              itemBuilder: (BuildContext context, int index) {
                // return _tile(data[index].title, data[index].synopsis, data[index].type);
                return Container(
                  margin: EdgeInsets.fromLTRB(30, 0, 30, 20),
                  child: SlideMenu(
                    onDataChange: onDataChange,
                    id: data![index].id!,
                    data: data![index],
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
                            onItemClicked(data![index]);
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
                                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
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
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: Row(children: [
                                              Icon(
                                                Icons.access_time_filled,
                                                size: 14,
                                                color: Color(0xff24573F),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
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
                                              '${data![index].qty.toString()} x',
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
