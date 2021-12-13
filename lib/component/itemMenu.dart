import 'package:flutter/material.dart';
import 'package:dzikirapp/component/route.dart';

class ItemMenu extends StatefulWidget {
  final Color color;
  final String textMenu;
  final String image;
  final int order;
  final String pageType;
  ItemMenu({
    required this.color,
    required this.textMenu,
    required this.image,
    required this.pageType,
    this.order = 1,
  });

  @override
  _ItemMenuState createState() => new _ItemMenuState();
}

class _ItemMenuState extends State<ItemMenu>
    with SingleTickerProviderStateMixin {
  bool _show = false;

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 800),
    vsync: this,
  );

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );

  @override
  initState() {
    super.initState();
    _runningAnimation();
  }

  void _runningAnimation() {
    int timer = 800 + (100 * widget.order);
    Future.delayed(Duration(milliseconds: timer), () {
      _controller.forward();
      setState(() {
        _show = true;
      });
    });
  }

  void _onItemClicked() {
    late var routeDzikir;

    if (widget.pageType == 'pagi') {
      routeDzikir = createRouteToDetailDzikir('pagi');
    } else if (widget.pageType == 'petang') {
      routeDzikir = createRouteToDetailDzikir('petang');
    } else if (widget.pageType == 'custom') {
      routeDzikir = createRouteToDzikirCustom();
    } else {
      routeDzikir = createRouteToAppInfo();
    }
    Navigator.of(context).push(routeDzikir);
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 183,
      height: 185,
      child: Stack(children: <Widget>[
        AnimatedPositioned(
          top: _show ? 0.0 : 30.0,
          left: 0,
          right: 0,
          duration: const Duration(seconds: 1),
          curve: Curves.fastOutSlowIn,
          child: FadeTransition(
            opacity: _animation,
            child: Container(
              margin: EdgeInsets.all(15),
              height: 145,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15)),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xff8D8D8D).withOpacity(0.25),
                    spreadRadius: 0,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: Color(0xffE8F0EF),
                  borderRadius: new BorderRadius.all(Radius.circular(15)),
                  onTap: () {
                    _onItemClicked();
                  },
                  child: Column(children: [
                    Container(
                      height: 104,
                      width: double.infinity,
                      child: Stack(children: [
                        Positioned(
                          bottom: 0,
                          right: 0,
                          height: 50,
                          child: Image(
                            image: AssetImage(widget.image),
                          ),
                        ),
                      ]),
                      decoration: BoxDecoration(
                        color: widget.color,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15)),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          widget.textMenu,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff24573F)),
                        )),
                  ]),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
