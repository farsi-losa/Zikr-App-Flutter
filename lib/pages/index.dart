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
  // This widget is the root of your application.

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
          color: Colors.white,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 240,
                child: Stack(children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xff24573F),
                    ),
                    height: 150,
                    width: double.infinity,
                    child: MyArc(diameter: double.infinity),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(
                        top: 40,
                      ),
                      width: 172,
                      height: 172,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(90)),
                      ),
                    ),
                  ),
                  Center(
                    child: FadeTransition(
                      opacity: _animation,
                      child: Container(
                        width: 104,
                        height: 54,
                        margin: EdgeInsets.only(
                          top: 40,
                        ),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                "assets/images/icon_dzikir_small.png"),
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
                          image: 'assets/images/pagi_icon.png',
                          pageType: 'pagi'),
                      ItemMenu(
                        order: 2,
                        color: Color(0xffAF9C4D),
                        textMenu: 'Dzikir petang',
                        image: 'assets/images/petang_icon.png',
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
                        textMenu: 'Dzikir custom',
                        image: 'assets/images/custom_dzikir_icon.png',
                        pageType: 'custom',
                      ),
                      ItemMenu(
                        order: 4,
                        color: Color(0xffB64839),
                        textMenu: 'App info',
                        image: 'assets/images/info_setting.png',
                        pageType: 'appinfo',
                      ),
                    ],
                  ),
                ]),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                color: Color(0xff2F6149),
                alignment: Alignment.center,
                child: Text(
                  'Dzikir App',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
