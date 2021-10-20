import 'package:flutter/material.dart';
import 'package:dzikirapp/db.dart';
import 'package:dzikirapp/component/dialogAddDzikir.dart';

class SlideMenu extends StatefulWidget {
  final Widget child;
  final int id;
  final data;
  final onDataChange;
  final dzikirType;

  SlideMenu(
      {required this.child,
      required this.id,
      this.data,
      this.onDataChange,
      required this.dzikirType});

  @override
  _SlideMenuState createState() => new _SlideMenuState();
}

class _SlideMenuState extends State<SlideMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late DatabaseHandler handler;
  late bool deleteClick;
  bool openAction = false;
  GlobalKey _toolTipKey = GlobalKey();

  @override
  initState() {
    super.initState();
    this.handler = DatabaseHandler();
    deleteClick = false;
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
    if (deleteClick) {
      _controller.animateTo(.0);

      setState(() {
        openAction = !openAction;
        deleteClick = false;
      });
      Future.delayed(const Duration(milliseconds: 300), () {
        this.handler.deleteDzikir(widget.id);
        widget.onDataChange();
      });
    } else {
      final dynamic tooltip = _toolTipKey.currentState;
      tooltip.ensureTooltipVisible();
      this.setState(() {
        deleteClick = true;
      });
      Future.delayed(const Duration(seconds: 2), () {
        tooltip.deactivate();
        this.setState(() {
          deleteClick = false;
        });
      });
    }
  }

  void _onEditItem() {
    _controller.animateTo(.0);
    setState(() {
      openAction = !openAction;
    });

    showDialog(
      context: context,
      builder: (context) {
        return DialogAddDzikir(
            method: 'edit',
            id: widget.data.id,
            name: widget.data.name,
            qty: widget.data.qty,
            lastCount: widget.data.lastcount,
            timer: widget.data.timer,
            dzikirType: widget.dzikirType);
      },
    ).then((value) {
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
                            color: deleteClick ? Colors.red : Color(0xffE8F0EF),
                            borderRadius: new BorderRadius.only(
                              topRight: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                            child: new InkWell(
                              splashColor: Color(0xffE8F0EF),
                              child: Tooltip(
                                key: _toolTipKey,
                                message: 'Click again to delete',
                                child: Container(
                                  height: 68,
                                  color: Colors.transparent,
                                  child: new Icon(Icons.delete,
                                      color: Color(0xff24573F)),
                                ),
                              ),
                              onTap: () {
                                return _onDeleteItem();
                              },
                            ),
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
              border: Border.all(
                width: 1.0,
                color: Color(0xffE8F0EF),
              ),
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
              ),
            ]),
          ),
        ),
      ],
    );
  }
}
