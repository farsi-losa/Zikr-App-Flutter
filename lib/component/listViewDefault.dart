import 'package:flutter/material.dart';

ListView dzikirDefaultListView(data, onDataChange, onItemClicked) {
  Color lastCountColor(int lastCount, int target) {
    var hasilbagi = lastCount / target * 100;
    if (hasilbagi <= 33 && hasilbagi != 0) return Color(0xffB64839);
    if ((hasilbagi > 33 && hasilbagi <= 66)) return Color(0xffAF9C4D);

    return Color(0xff24573F);
  }

  return ListView.builder(
    itemCount: data.length,
    scrollDirection: Axis.horizontal,
    shrinkWrap: true,
    itemBuilder: (BuildContext context, int index) {
      return Container(
        margin: EdgeInsets.fromLTRB(25, 0, 0, 0),
        width: 125,
        height: 150,
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          ),
        ),
        child: new Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Color(0xffE8F0EF),
            borderRadius: new BorderRadius.only(
              topLeft: Radius.circular(15),
              bottomLeft: Radius.circular(15),
            ),
            onTap: () {
              onItemClicked(data![index], 'dafault');
            },
            child: Column(children: [
              Align(
                alignment: Alignment.topLeft,
                child: ConstrainedBox(
                  constraints: new BoxConstraints(
                    minWidth: 85.0,
                    maxWidth: 125.0,
                  ),
                  child: Container(
                    height: 36,
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 7),
                    child: Text(
                      data![index].name,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    decoration: new BoxDecoration(
                      color: Color(0xff93BC9C),
                      borderRadius: new BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  height: 86,
                  child: Center(
                    child: Text(
                      data[index].lastcount.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 48,
                        color: lastCountColor(
                            data[index].lastcount, data[index].qty),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 28,
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(children: [
                          Icon(
                            Icons.access_time_filled,
                            size: 14,
                            color: Color(0xff24573F),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: Text(
                              '${data![index].timer.toString()}',
                            ),
                          ),
                          Text(
                            'ms',
                          ),
                        ]),
                      ),
                      Text(
                        '${data![index].qty.toString()} x',
                      ),
                    ]),
              ),
            ]),
          ),
        ),
      );
    },
  );
}

GridView animeGridView(data) {
  return GridView.count(
    crossAxisCount: 2,
    crossAxisSpacing: 10.0,
    mainAxisSpacing: 10.0,
    shrinkWrap: true,
    children: List.generate(
      20,
      (index) {
        return Container(
          width: 160.0,
          margin: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 4 / 3,
                child: Image.network(data[index].image, fit: BoxFit.fitWidth),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
                child: Text(
                  data[index].title,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withAlpha(20),
                blurRadius: 4,
                offset: Offset(4, 4), // Shadow position
              ),
            ],
            borderRadius: BorderRadius.circular(4),
          ),
        );
      },
    ),
  );
}
