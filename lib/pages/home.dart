import 'package:flutter/material.dart';
import 'package:dzikirapp/db.dart';
// import 'package:dzikirapp/component/itemListDzikir.dart';
import 'package:dzikirapp/component/dialogAddDzikir.dart';

class AppHome extends StatefulWidget {
  AppHome({Key? key}) : super(key: key);
  @override
  _AppHome createState() => _AppHome();
}

class _AppHome extends State<AppHome> {
  // This widget is the root of your application.
  late final Future<List<Dzikir>> dzikirList;
  late DatabaseHandler handler;

  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;

  @override
  void initState() {
    super.initState();
    this.handler = DatabaseHandler();
  }

  void _showAddDzikirModal() {
    showDialog(
      context: context,
      builder: (context) => DialogAddDzikir(),
    ).then((value) {
      print(value);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FutureBuilder(
            future: this.handler.retrieveDzikirs(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Dzikir>> snapshot) {
              if (snapshot.hasData) {
                return Container(
                  color: Color(0xffE7EFEE),
                  child: CustomScrollView(
                    slivers: <Widget>[
                      SliverAppBar(
                        pinned: _pinned,
                        snap: _snap,
                        floating: _floating,
                        stretch: true,
                        backgroundColor: Color(0xffE7EFEE),
                        expandedHeight: 200.0,
                        flexibleSpace: const FlexibleSpaceBar(
                          title: Text(
                            'Dzikir Favorites',
                            style: TextStyle(
                                color: Color(0xff93BC9C), fontSize: 18),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          height: 40,
                          margin: const EdgeInsets.only(bottom: 40),
                          decoration: new BoxDecoration(
                            color: Colors.white,
                            borderRadius: new BorderRadius.only(
                                topRight: Radius.circular(40)),
                          ),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return Container(
                              margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
                              child: Dismissible(
                                direction: DismissDirection.endToStart,
                                background: Container(
                                  color: Color(0xff93BC9C),
                                  alignment: Alignment.centerRight,
                                  child: Icon(Icons.delete_forever),
                                ),
                                key: ValueKey<int>(snapshot.data![index].id!),
                                onDismissed:
                                    (DismissDirection direction) async {
                                  await this
                                      .handler
                                      .deleteUser(snapshot.data![index].id!);
                                  setState(() {
                                    snapshot.data!
                                        .remove(snapshot.data![index]);
                                  });
                                },
                                child: Card(
                                  child: Row(children: [
                                    Container(
                                      height: 68,
                                      width: 70,
                                      child: Center(
                                        child: Text(
                                          index.toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 28),
                                        ),
                                      ),
                                      decoration: new BoxDecoration(
                                        color: Color(0xff24573F),
                                        borderRadius: new BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            bottomRight: Radius.circular(15),
                                            bottomLeft: Radius.circular(15)),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 0, 20, 0),
                                        child: Column(children: [
                                          Container(
                                            height: 34,
                                            width: double.infinity,
                                            child: Text(
                                              snapshot.data![index].name,
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      width: 1.0,
                                                      color:
                                                          Color(0xffE7EFEE))),
                                            ),
                                          ),
                                          Text(
                                              '${snapshot.data![index].qty.toString()} x'),
                                        ]),
                                      ),
                                    ),
                                    Container(
                                      width: 52,
                                      child: Center(child: Text('sdsd')),
                                    ),
                                  ]),
                                ),
                              ),
                            );
                          },
                          childCount: snapshot.data?.length,
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showAddDzikirModal();
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
