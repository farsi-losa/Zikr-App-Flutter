import 'package:flutter/material.dart';
import 'package:dzikirapp/db.dart';
import 'package:dzikirapp/component/dialogAddDzikir.dart';
import 'package:dzikirapp/component/slideMenu.dart';
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
  bool openAction = false;

  void onTapOptionItem() {
    print(openAction);
    setState(() {
      openAction = !openAction;
    });
  }

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

  void _onDeleteItem() {
    this.setState(() {});
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
                        elevation: 0.0,
                        snap: _snap,
                        floating: _floating,
                        stretch: true,
                        centerTitle: true,
                        backgroundColor: Color(0xffE7EFEE),
                        expandedHeight: 140.0,
                        flexibleSpace: FlexibleSpaceBar(
                          centerTitle: true,
                          title: Text(
                            'YOURS DZIKIR',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xff93BC9C), fontSize: 18),
                          ),
                          background: Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              new Positioned(
                                right: 40.0,
                                top: -50.0,
                                child: new RotationTransition(
                                  turns: new AlwaysStoppedAnimation(40 / 360),
                                  child: Container(
                                    width: 109,
                                    height: 105,
                                    decoration: new BoxDecoration(
                                      color: Color(0xffC0685C),
                                      borderRadius: new BorderRadius.all(
                                          Radius.circular(30)),
                                    ),
                                  ),
                                ),
                              ),
                              new Positioned(
                                left: 40.0,
                                top: 130.0,
                                child: new RotationTransition(
                                  turns: new AlwaysStoppedAnimation(130 / 360),
                                  child: Container(
                                    width: 109,
                                    height: 120,
                                    decoration: new BoxDecoration(
                                      color: Color(0xff24573F),
                                      borderRadius: new BorderRadius.all(
                                          Radius.circular(30)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
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
                                  topRight: Radius.circular(40),
                                  topLeft: Radius.circular(40)),
                            ),
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.only(bottom: 100),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return Container(
                                margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
                                child: SlideMenu(
                                  deleteItem: _onDeleteItem,
                                  id: snapshot.data![index].id!,
                                  child: Container(
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
                                        child: InkWell(
                                          onTap: () {
                                            _onItemClicked(
                                                snapshot.data![index]);
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 0, 0, 0),
                                            child: Column(children: [
                                              Container(
                                                height: 34,
                                                alignment: Alignment.centerLeft,
                                                width: double.infinity,
                                                child: Text(
                                                  snapshot.data![index].name,
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                ),
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          width: 1.0,
                                                          color: Color(
                                                              0xffE7EFEE))),
                                                ),
                                              ),
                                              Container(
                                                height: 34,
                                                alignment:
                                                    Alignment.centerRight,
                                                width: double.infinity,
                                                child: Text(
                                                    '${snapshot.data![index].qty.toString()} x'),
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          width: 1.0,
                                                          color: Color(
                                                              0xffE7EFEE))),
                                                ),
                                              ),
                                            ]),
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ),
                                ),
                              );
                            },
                            childCount: snapshot.data?.length,
                          ),
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
