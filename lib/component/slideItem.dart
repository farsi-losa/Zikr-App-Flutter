import 'package:flutter/material.dart';
import 'package:dzikirapp/db.dart';
import 'package:dzikirapp/component/dialogAddDzikir.dart';

class SlideMenu extends StatefulWidget {
  final Widget child;
  final int id;
  final data;
  final onDataChange;

  SlideMenu({
    required this.child,
    required this.id,
    this.data,
    this.onDataChange,
  });

  @override
  _SlideMenuState createState() => new _SlideMenuState();
}

class _SlideMenuState extends State<SlideMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late DatabaseHandler handler;
  bool openAction = false;

  @override
  initState() {
    super.initState();
    this.handler = DatabaseHandler();
    openAction = false;
    _controller = new AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
  }

  void onTap() {
    if (!openAction) {
      _controller.animateTo(1.0);
    } else {
      _controller.animateTo(.0);
    }
    setState(() {
      openAction = !openAction;
    });
  }

  void _onDeleteItem() {
    _controller.animateTo(.0);

    setState(() {
      openAction = !openAction;
    });
    Future.delayed(const Duration(milliseconds: 300), () {
      this.handler.deleteUser(widget.id);
      widget.onDataChange();
    });
  }

  void _onEditItem() {
    _controller.animateTo(.0);
    setState(() {
      openAction = !openAction;
    });

    showDialog(
      // transitionAnimationController: modalController,
      context: context,
      builder: (context) {
        return DialogAddDzikir(
            method: 'edit',
            id: widget.data.id,
            name: widget.data.name,
            qty: widget.data.qty,
            timer: widget.data.timer);
      },
    ).then((value) {
      print(value);
      widget.onDataChange();
    });
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final animation = new Tween(
            begin: const Offset(0.0, 0.0), end: const Offset(-0.4, 0.0))
        .animate(new CurveTween(curve: Curves.decelerate).animate(_controller));

    return Stack(
      children: <Widget>[
        new Positioned.fill(
          child: new LayoutBuilder(
            builder: (context, constraint) {
              return Stack(
                children: <Widget>[
                  new Positioned(
                    right: .0,
                    top: .0,
                    bottom: .0,
                    width: ((constraint.maxWidth / 10) * 4) + 15,
                    child: new Container(
                      padding: const EdgeInsets.only(left: 15),
                      decoration: new BoxDecoration(
                        color: Color(0xffE8F0EF),
                        borderRadius: new BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                      child: new Row(children: <Widget>[
                        Expanded(
                          child: Material(
                            color: Color(0xffE8F0EF),
                            borderRadius: new BorderRadius.only(
                              topRight: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                            child: new InkWell(
                              splashColor: Color(0xffE8F0EF),
                              child: Container(
                                height: 68,
                                color: Colors.transparent,
                                child: new Icon(Icons.edit,
                                    color: Color(0xff24573F)),
                              ),
                              onTap: () {
                                _onEditItem();
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: Material(
                            color: Color(0xffE8F0EF),
                            borderRadius: new BorderRadius.only(
                              topRight: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                            child: new InkWell(
                                splashColor: Color(0xffE8F0EF),
                                child: Container(
                                  height: 68,
                                  color: Colors.transparent,
                                  child: new Icon(Icons.delete,
                                      color: Color(0xff24573F)),
                                ),
                                onTap: () {
                                  _onDeleteItem();
                                }),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        new SlideTransition(
          position: animation,
          child: Container(
            decoration: new BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.20),
                  spreadRadius: 0,
                  blurRadius: 10,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ],
              borderRadius: new BorderRadius.all(Radius.circular(15)),
            ),
            child: Row(children: [
              Expanded(child: widget.child),
              Material(
                color: Colors.transparent,
                borderRadius: new BorderRadius.only(
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                child: InkWell(
                  splashColor: Color(0xffE8F0EF),
                  borderRadius: new BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  onTap: () => {onTap()},
                  child: Container(
                    width: 68,
                    height: 68,
                    child: Icon(Icons.more_vert),
                  ),
                ),
                // ),
              ),
            ]),
          ),
        ),
      ],
    );
  }
}
