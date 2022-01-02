import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:dzikirapp/component/circle.dart';
import 'package:dzikirapp/component/itemMenu.dart';
import 'package:dzikirapp/models/settings.dart';
import 'package:provider/provider.dart';

class AppIndex extends StatefulWidget {
  AppIndex({Key? key}) : super(key: key);

  @override
  _AppIndex createState() => _AppIndex();
}

class _AppIndex extends State<AppIndex> with TickerProviderStateMixin {
  bool _show = false;

  String appVersion = '0.0.0';

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  );

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );

  @override
  void initState() {
    super.initState();
    _controller.forward();
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      setState(() {
        appVersion = packageInfo.version;
      });
      _show = true;
    });
  }

  @override
  void dispose() {
    _controller.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SettingsModel()),
        FutureProvider<bool>(
          create: (context) => SettingsModel().fetchSetting,
          initialData: true,
        ),
      ],
      child: Scaffold(
        body: Container(
          color: Color(0xffE8F0EF),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 260,
                child: Stack(children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xff24573F),
                    ),
                    height: 180,
                    width: double.infinity,
                    child: Stack(children: <Widget>[
                      Positioned(
                        top: 70,
                        right: -150,
                        child: Opacity(
                          opacity: 0.15,
                          child: Container(
                            width: 280,
                            height: 280,
                            decoration: BoxDecoration(
                              color: Color(0xff93BC9C),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(140)),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: -110,
                        left: -30,
                        child: Opacity(
                          opacity: 0.1,
                          child: Container(
                            width: 198,
                            height: 198,
                            decoration: BoxDecoration(
                              color: Color(0xff93BC9C),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                  AnimatedPositioned(
                    top: _show ? 120.0 : 60.0,
                    left: 0,
                    right: 0,
                    duration: const Duration(seconds: 2),
                    curve: Curves.fastOutSlowIn,
                    child: Center(
                      child: FadeTransition(
                        opacity: _animation,
                        child: Container(
                          // margin: EdgeInsets.only(
                          //   top: 40,
                          // ),
                          padding: EdgeInsets.all(28),
                          width: 362,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xff8D8D8D).withOpacity(0.25),
                                spreadRadius: 0,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 180,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Dzikir app',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xffAF9C4D),
                                          fontSize: 20),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 8),
                                      child: Text(
                                        'Dengan berdzikir hati menjadi tenang',
                                        style: TextStyle(
                                            color: Color(0xff24573F),
                                            fontWeight: FontWeight.w300),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width: 104,
                                height: 54,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/icon_dzikir_small.png"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
              Container(
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ItemMenu(
                          order: 1,
                          color: Color(0xffE8F0EF),
                          textMenu: 'Dzikir pagi',
                          image: 'assets/images/pagi_icon_color.png',
                          pageType: 'pagi'),
                      ItemMenu(
                        order: 2,
                        color: Color(0xffAF9C4D),
                        textMenu: 'Dzikir petang',
                        image: 'assets/images/petang_icon_color.png',
                        pageType: 'petang',
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ItemMenu(
                        order: 3,
                        color: Color(0xff93BC9C),
                        textMenu: 'Dzikir counter',
                        image: 'assets/images/counter_dzikir.png',
                        pageType: 'custom',
                      ),
                      ItemMenu(
                        order: 4,
                        color: Color(0xffB64839),
                        textMenu: 'App info',
                        image: 'assets/images/info_setting_color.png',
                        pageType: 'appinfo',
                      ),
                    ],
                  ),
                ]),
              ),
              Spacer(),
              Container(
                height: 15,
                color: Color(0xffAF9C4D),
                alignment: Alignment.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
