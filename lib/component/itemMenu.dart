import 'package:flutter/material.dart';
import 'package:dzikirapp/component/route.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

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
    int timer = 800 + (200 * widget.order);
    Future.delayed(Duration(milliseconds: timer), () {
      _controller.forward();
      setState(() {
        _show = true;
      });
    });
  }

  void _onItemClicked(String languageCode) {
    late var routeDzikir;

    FirebaseAnalytics analytics = FirebaseAnalytics.instance;

    if (widget.pageType == 'pagi') {
      routeDzikir = createRouteToDetailDzikir('pagi', languageCode);
      analytics.logEvent(name: 'dzikir_pagi_click', parameters: null);
    } else if (widget.pageType == 'petang') {
      routeDzikir = createRouteToDetailDzikir('petang', languageCode);
      analytics.logEvent(name: 'dzikir_petang_click', parameters: null);
    } else if (widget.pageType == 'custom') {
      routeDzikir = createRouteToDzikirCustom();
      analytics.logEvent(name: 'dzikir_custom_click', parameters: null);
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
    final String langCode = Localizations.localeOf(context).languageCode;
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
                    color: Color(0xff8D8D8D).withAlpha(20),
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
                    _onItemClicked(langCode);
                  },
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            height: 65,
                            padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
                            child: Text(
                              widget.textMenu,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff24573F)),
                            )),
                        Container(
                          height: 80,
                          width: double.infinity,
                          child: Stack(children: [
                            Positioned(
                              bottom: -0.5,
                              right: 0,
                              width: 111,
                              child: Image(
                                image: AssetImage(widget.image),
                              ),
                            ),
                          ]),
                        ),
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
