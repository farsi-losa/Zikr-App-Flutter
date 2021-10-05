import 'package:flutter/material.dart';
import 'package:dzikirapp/db.dart';
// import 'package:dzikirapp/component/itemListDzikir.dart';
import 'package:dzikirapp/component/dialogAddDzikir.dart';
import 'package:dzikirapp/pages/dzikir_counter.dart';

class AppHome extends StatefulWidget {
  AppHome({Key? key}) : super(key: key);
  @override
  _AppHome createState() => _AppHome();
}

class _AppHome extends State<AppHome> with TickerProviderStateMixin {
  // This widget is the root of your application.
  late final Future<List<Dzikir>> dzikirList;
  late DatabaseHandler handler;
  late AnimationController modalController;

  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;

  @override
  void initState() {
    super.initState();
    this.handler = DatabaseHandler();
    initController();
  }

  void initController() {
    modalController = BottomSheet.createAnimationController(this);
    modalController.duration = Duration(milliseconds: 500);
    modalController.reverseDuration = const Duration(milliseconds: 100);
  }

  void _showAddDzikirModal() {
    showModalBottomSheet(
      transitionAnimationController: modalController,
      context: context,
      builder: (context) => DialogAddDzikir(),
    ).then((value) {
      print(value);
      setState(() {});
    }).whenComplete(() => initController());
  }

  void _onItemClicked(data) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            StackOver(timer: data.timer, name: data.name, qty: data.qty),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    modalController.dispose();
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
                  color: Colors.white,
                  child: CustomScrollView(
                    slivers: <Widget>[
                      SliverAppBar(
                        pinned: _pinned,
                        snap: _snap,
                        floating: _floating,
                        stretch: true,
                        backgroundColor: Color(0xffE7EFEE),
                        expandedHeight: 200.0,
                        flexibleSpace: FlexibleSpaceBar(
                          title: Text(
                            'Dzikir Favorites',
                            style: TextStyle(
                                color: Color(0xff93BC9C), fontSize: 18),
                          ),
                          // background: Stack(
                          //   fit: StackFit.expand,
                          //   children: <Widget>[
                          //     new Positioned(
                          //       right: 40.0,
                          //       top: 130.0,
                          //       child: new RotationTransition(
                          //         turns: new AlwaysStoppedAnimation(130 / 360),
                          //         child: Container(
                          //           width: 109,
                          //           height: 168,
                          //           color: Color(0xff24573F),
                          //         ),
                          //       ),
                          //     ),
                          //     new Positioned(
                          //       left: 30.0,
                          //       top: 30.0,
                          //       child: Container(
                          //         width: 109,
                          //         height: 185,
                          //         color: Color(0xffC0685C),
                          //       ),
                          //     )
                          //   ],
                          // ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          color: Color(0xffE7EFEE),
                          child: Container(
                            height: 40,
                            decoration: new BoxDecoration(
                              color: Colors.white,
                              borderRadius: new BorderRadius.only(
                                  topRight: Radius.circular(40)),
                            ),
                          ),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                _onItemClicked(snapshot.data![index]);
                              },
                              child: Container(
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
                                  child: Container(
                                    decoration: new BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.20),
                                          spreadRadius: 0,
                                          blurRadius: 14,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                      borderRadius: new BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          bottomRight: Radius.circular(15),
                                          bottomLeft: Radius.circular(15)),
                                    ),
                                    child: Row(children: [
                                      Container(
                                        height: 68,
                                        width: 70,
                                        child: Center(
                                          child: Text(
                                            (index + 1).toString(),
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
                                                style: TextStyle(fontSize: 16),
                                              ),
                                              decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        width: 1.0,
                                                        color:
                                                            Color(0xffE7EFEE))),
                                              ),
                                            ),
                                            Container(
                                              height: 34,
                                              width: double.infinity,
                                              child: Text(
                                                  '${snapshot.data![index].qty.toString()} x'),
                                              decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        width: 1.0,
                                                        color:
                                                            Color(0xffE7EFEE))),
                                              ),
                                            ),
                                          ]),
                                        ),
                                      ),
                                      Container(
                                        width: 52,
                                        child: Container(
                                            child: Icon(Icons.arrow_right)),
                                      ),
                                    ]),
                                  ),
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
          backgroundColor: Color(0xff24573F),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
      ),
    );
  }
}
