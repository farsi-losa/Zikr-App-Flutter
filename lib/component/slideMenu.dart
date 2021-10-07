import 'package:flutter/material.dart';
import 'package:dzikirapp/db.dart';

class SlideMenu extends StatefulWidget {
  final Widget child;
  final int id;
  final deleteItem;

  SlideMenu({required this.child, required this.id, this.deleteItem});

  @override
  _SlideMenuState createState() => new _SlideMenuState();
}

class _SlideMenuState extends State<SlideMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late DatabaseHandler handler;
  bool openAction = false;

  void onTap() {
    if (openAction) {
      _controller.animateTo(1.0);
      // Future.delayed(const Duration(milliseconds: 1000), () {
      //   _controller.animateTo(.0);
      //   setState(() {
      //     openAction = !openAction;
      //   });
      // });
    } else {
      _controller.animateTo(.0);
    }
    setState(() {
      openAction = !openAction;
    });
  }

  void _onDeleteItem() {
    print(widget.id);
    _controller.animateTo(.0);
    setState(() {
      openAction = !openAction;
    });
    Future.delayed(const Duration(milliseconds: 250), () {
      this.handler.deleteUser(widget.id);
      widget.deleteItem();
    });
  }

  @override
  initState() {
    super.initState();
    this.handler = DatabaseHandler();
    _controller = new AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
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

    return new Stack(
      children: <Widget>[
        new Positioned.fill(
          child: new LayoutBuilder(
            builder: (context, constraint) {
              return new AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return new Stack(
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
                              child: Container(
                                child: new IconButton(
                                  color: Color(0xff24573F),
                                  icon: new Icon(Icons.edit),
                                  onPressed: () {},
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: new IconButton(
                                    color: Color(0xff24573F),
                                    icon: new Icon(Icons.delete),
                                    onPressed: () {
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
                  blurRadius: 14,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              borderRadius: new BorderRadius.all(Radius.circular(15)),
            ),
            child: Row(children: [
              Expanded(child: widget.child),
              GestureDetector(
                onTap: () => {onTap()},
                onHorizontalDragUpdate: (data) {
                  // we can access context.size here
                  setState(() {
                    _controller.value -=
                        (data.primaryDelta! / context.size!.width);
                  });
                },
                onHorizontalDragEnd: (data) {
                  if (data.primaryVelocity! > 500)
                    _controller.animateTo(
                        .0); //close menu on fast swipe in the right direction
                  else if (_controller.value >= .5 ||
                      data.primaryVelocity! < -100) {
                    // fully open if dragged a lot to left or on fast swipe to left
                    _controller.animateTo(1.0);
                    // Future.delayed(const Duration(milliseconds: 1000), () {
                    //   _controller.animateTo(.0);
                    //   setState(() {
                    //     openAction = !openAction;
                    //   });
                    // });
                  } else // close if none of above
                    _controller.animateTo(.0);
                },
                child: Container(
                  width: 68,
                  height: 68,
                  color: Colors.white,
                  child: Icon(Icons.more_vert),
                ),
              ),
            ]),
          ),
        ),
      ],
    );
  }
}
