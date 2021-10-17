import 'package:flutter/material.dart';
import 'package:dzikirapp/db.dart';
import 'package:dzikirapp/component/listView.dart';
import 'package:dzikirapp/component/listViewDefault.dart';
import 'package:dzikirapp/component/route.dart';

class AppHome extends StatefulWidget {
  AppHome({Key? key}) : super(key: key);
  @override
  _AppHome createState() => _AppHome();
}

class _AppHome extends State<AppHome> with TickerProviderStateMixin {
  // This widget is the root of your application.
  final ScrollController scrollcontroller = new ScrollController();
  late DatabaseHandler handler;
  late AnimationController modalController;

  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;
  bool openAction = false;

  bool scroll_visibility = true;

  void onTapOptionItem() {
    setState(() {
      openAction = !openAction;
    });
  }

  @override
  void initState() {
    super.initState();
    this.handler = DatabaseHandler();
    scrollcontroller.addListener(() {
      if (scrollcontroller.position.pixels > 0 ||
          scrollcontroller.position.pixels <
              scrollcontroller.position.maxScrollExtent)
        scroll_visibility = false;
      else
        scroll_visibility = true;

      setState(() {});
    });
    initController();
  }

  void initController() {
    modalController = BottomSheet.createAnimationController(this);
    modalController.duration = Duration(milliseconds: 500);
    modalController.reverseDuration = const Duration(milliseconds: 100);
  }

  void _onItemClicked(data) {
    Navigator.of(context).push(createRoute(data)).then((value) {
      _onDataChange();
    });
  }

  void _onDataChange() {
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
          future: Future.wait([
            this.handler.retrieveDzikirsDefault(),
            this.handler.retrieveDzikirs(),
          ]),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.hasData) {
              // List<Anime> data = snapshot.data;
              return Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  child: Column(children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.all(9),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 5),
                        child: Text(
                          'Naruto',
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    ),
                    Container(
                      height: 150,
                      child: dzikirDefaultListView(
                          snapshot.data![0], _onDataChange, _onItemClicked),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.all(9),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 5),
                        child: Text(
                          'Pokemon',
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    ),
                    Container(
                      child: DzikirListView(
                          data: snapshot.data![1],
                          onDataChange: _onDataChange,
                          onItemClicked: _onItemClicked),
                    ),
                  ]),
                ),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
        // body: FutureBuilder(
        //   future: this.handler.retrieveDzikirs('dzikirs'),
        //   builder:
        //       (BuildContext context, AsyncSnapshot<List<Dzikir>> snapshot) {
        //     if (snapshot.hasData) {
        //       return Container(
        //         color: Colors.white,
        //         child: CustomScrollView(
        //           slivers: <Widget>[
        //             SliverAppBar(
        //               pinned: _pinned,
        //               elevation: 0.0,
        //               snap: _snap,
        //               floating: _floating,
        //               stretch: true,
        //               centerTitle: true,
        //               backgroundColor: Color(0xffE7EFEE),
        //               expandedHeight: 140.0,
        //               flexibleSpace: FlexibleSpaceBar(
        //                 centerTitle: true,
        //                 title: Text(
        //                   'DZIKIR LIST',
        //                   textAlign: TextAlign.center,
        //                   style:
        //                       TextStyle(color: Color(0xff93BC9C), fontSize: 18),
        //                 ),
        //                 background: Stack(
        //                   fit: StackFit.expand,
        //                   children: <Widget>[
        //                     new Positioned(
        //                       right: 40.0,
        //                       top: -50.0,
        //                       child: new RotationTransition(
        //                         turns: new AlwaysStoppedAnimation(40 / 360),
        //                         child: Container(
        //                           width: 109,
        //                           height: 105,
        //                           decoration: new BoxDecoration(
        //                             color: Color(0xffC0685C),
        //                             borderRadius: new BorderRadius.all(
        //                                 Radius.circular(30)),
        //                           ),
        //                         ),
        //                       ),
        //                     ),
        //                     new Positioned(
        //                       left: -10.0,
        //                       top: -90.0,
        //                       child: new RotationTransition(
        //                         turns: new AlwaysStoppedAnimation(130 / 360),
        //                         child: Container(
        //                           width: 109,
        //                           height: 220,
        //                           decoration: new BoxDecoration(
        //                             color: Color(0xff24573F),
        //                             borderRadius: new BorderRadius.all(
        //                                 Radius.circular(30)),
        //                           ),
        //                         ),
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             ),
        //             SliverToBoxAdapter(
        //               child: Container(
        //                 padding: const EdgeInsets.only(top: 20),
        //                 color: Color(0xffE7EFEE),
        //                 child: Container(
        //                   height: snapshot.data?.length == 0 ? null : 40,
        //                   child: snapshot.data?.length == 0
        //                       ? Column(
        //                           children: [
        //                             Center(
        //                               child: Container(
        //                                 margin: EdgeInsets.only(top: 100),
        //                                 width: 190,
        //                                 height: 140,
        //                                 decoration: BoxDecoration(
        //                                   image: DecorationImage(
        //                                     image: AssetImage(
        //                                         "assets/images/empty_dzikir.png"),
        //                                     fit: BoxFit.fitWidth,
        //                                   ),
        //                                 ),
        //                               ),
        //                             ),
        //                             Padding(
        //                               padding:
        //                                   EdgeInsets.only(top: 30, bottom: 10),
        //                               child: Text(
        //                                 'Start by adding  a dzikir',
        //                                 style: TextStyle(
        //                                     fontSize: 18,
        //                                     fontWeight: FontWeight.bold),
        //                               ),
        //                             ),
        //                             Container(
        //                               width: 280,
        //                               child: Text(
        //                                 'Click on the button at the bottom to add a new dzikir',
        //                                 textAlign: TextAlign.center,
        //                               ),
        //                             ),
        //                           ],
        //                         )
        //                       : null,
        //                   decoration: new BoxDecoration(
        //                     color: Colors.white,
        //                     boxShadow: [
        //                       BoxShadow(
        //                         color: Colors.grey.withOpacity(0.10),
        //                         spreadRadius: 0,
        //                         blurRadius: 7,
        //                         offset:
        //                             Offset(0, -8), // changes position of shadow
        //                       ),
        //                     ],
        //                     borderRadius: new BorderRadius.only(
        //                         topRight: Radius.circular(30),
        //                         topLeft: Radius.circular(30)),
        //                   ),
        //                 ),
        //               ),
        //             ),
        //             SliverPadding(
        //               padding: const EdgeInsets.only(bottom: 30, top: 20),
        //               sliver: SliverList(
        //                 delegate: SliverChildBuilderDelegate(
        //                   (BuildContext context, int index) {
        //                     return Container(
        //                       margin: EdgeInsets.fromLTRB(30, 0, 30, 30),
        //                       child: SlideMenu(
        //                         onDataChange: _onDataChange,
        //                         id: snapshot.data![index].id!,
        //                         data: snapshot.data![index],
        //                         child: Container(
        //                           child: new Material(
        //                             color: Colors.transparent,
        //                             child: InkWell(
        //                               splashColor: Color(0xffE8F0EF),
        //                               borderRadius: new BorderRadius.only(
        //                                 topLeft: Radius.circular(15),
        //                                 bottomLeft: Radius.circular(15),
        //                               ),
        //                               onTap: () {
        //                                 _onItemClicked(snapshot.data![index]);
        //                               },
        //                               child: Row(children: [
        //                                 Container(
        //                                   height: 50,
        //                                   width: 54,
        //                                   margin: EdgeInsets.all(10),
        //                                   child: Center(
        //                                     child: Text(
        //                                       (index + 1).toString(),
        //                                       style: TextStyle(
        //                                           color: Colors.white,
        //                                           fontSize: 20),
        //                                     ),
        //                                   ),
        //                                   decoration: new BoxDecoration(
        //                                     color: Color(0xff24573F),
        //                                     borderRadius: new BorderRadius.only(
        //                                       topLeft: Radius.circular(10),
        //                                       bottomLeft: Radius.circular(10),
        //                                       bottomRight: Radius.circular(10),
        //                                     ),
        //                                   ),
        //                                 ),
        //                                 Expanded(
        //                                   child: Container(
        //                                     padding: const EdgeInsets.fromLTRB(
        //                                         10, 0, 0, 0),
        //                                     child: Column(children: [
        //                                       Container(
        //                                         height: 24,
        //                                         width: double.infinity,
        //                                         alignment: Alignment.centerLeft,
        //                                         child: Text(
        //                                           snapshot.data![index].name
        //                                               .toUpperCase(),
        //                                           overflow:
        //                                               TextOverflow.ellipsis,
        //                                           style: TextStyle(
        //                                               fontSize: 18,
        //                                               color: Color(0xff24573F),
        //                                               fontWeight:
        //                                                   FontWeight.bold),
        //                                         ),
        //                                         decoration: BoxDecoration(
        //                                           border: Border(
        //                                             bottom: BorderSide(
        //                                               width: 1.0,
        //                                               color: Color(0xffE7EFEE),
        //                                             ),
        //                                           ),
        //                                         ),
        //                                       ),
        //                                       Container(
        //                                         height: 24,
        //                                         alignment:
        //                                             Alignment.centerRight,
        //                                         width: double.infinity,
        //                                         child: Row(
        //                                             mainAxisAlignment:
        //                                                 MainAxisAlignment
        //                                                     .spaceBetween,
        //                                             children: [
        //                                               Container(
        //                                                 child: Row(children: [
        //                                                   Icon(
        //                                                     Icons
        //                                                         .access_time_filled,
        //                                                     size: 14,
        //                                                     color: Color(
        //                                                         0xff24573F),
        //                                                   ),
        //                                                   Padding(
        //                                                     padding: EdgeInsets
        //                                                         .symmetric(
        //                                                             horizontal:
        //                                                                 4),
        //                                                     child: Text(
        //                                                       '${snapshot.data![index].timer.toString()}',
        //                                                     ),
        //                                                   ),
        //                                                   Text(
        //                                                     'ms',
        //                                                   ),
        //                                                 ]),
        //                                               ),
        //                                               Align(
        //                                                 alignment:
        //                                                     Alignment.center,
        //                                                 child: Text(
        //                                                   '${snapshot.data![index].qty.toString()} x',
        //                                                 ),
        //                                               ),
        //                                             ]),
        //                                       ),
        //                                     ]),
        //                                   ),
        //                                 ),
        //                               ]),
        //                             ),
        //                           ),
        //                         ),
        //                       ),
        //                     );
        //                   },
        //                   childCount: snapshot.data?.length,
        //                 ),
        //               ),
        //             ),
        //           ],
        //         ),
        //       );
        //     } else {
        //       return Center(child: CircularProgressIndicator());
        //     }
        //   },
        // ),
      ),
    );
  }
}
