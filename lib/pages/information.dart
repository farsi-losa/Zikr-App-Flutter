import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:dzikirapp/db.dart';
import 'package:dzikirapp/models/globalCounter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AppInformation extends StatefulWidget {
  AppInformation({Key? key}) : super(key: key);
  @override
  _AppInformation createState() => _AppInformation();
}

class _AppInformation extends State<AppInformation> {
  // This widget is the root of your application.

  late DatabaseHandler handler;
  late bool _showDzikirReference;
  late Settings _dzikirReference;
  String appVersion = '0.0.0';

  @override
  void initState() {
    super.initState();
    this.handler = DatabaseHandler();
    // print(_getSettingByCode());
    this.handler.retrieveSettingsByCode('dzikir_default').then((data) {
      print(data);
      _dzikirReference = data;
      return data;
    }, onError: (e) {
      print(e);
    });
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      setState(() {
        appVersion = packageInfo.version;
      });
    });
  }

  Future<int> _updateSettingReference(value) async {
    Settings setting = Settings(
        id: _dzikirReference.id,
        name: _dzikirReference.name,
        active: value ? 0 : 1,
        featureCode: _dzikirReference.featureCode);
    return await this.handler.updateSetting(setting);
  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  void _referenceOnchange(value) {
    var globalCounter = Provider.of<SettingsModel>(context, listen: false);
    _updateSettingReference(value);
    globalCounter.setDzikirReference(value);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    const _url =
        'https://play.google.com/store/apps/details?id=com.farsi.dzikirapp';
    var globalCounter = Provider.of<SettingsModel>(context, listen: false);
    return MaterialApp(
      home: Scaffold(
        body: Container(
          color: Color(0xffE8F0EF),
          child: Column(
            children: [
              Container(
                height: 380,
                child: Stack(children: <Widget>[
                  Positioned(
                    left: 0.0,
                    right: 0.0,
                    top: 20.0,
                    // bottom: 40.0,
                    child: Container(
                      height: 280,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                      ),
                      child: Container(
                        margin: EdgeInsets.only(top: 80, bottom: 140),
                        width: 76,
                        height: 39,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                "assets/images/icon_dzikir_small.png"),
                            // fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 25.0,
                    right: 15.0,
                    top: 230.0,
                    child: Container(
                      height: 150,
                      margin: const EdgeInsets.fromLTRB(35, 0, 35, 20),
                      padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color(0xff24573F),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 3,
                            offset: Offset(2, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(children: [
                        Text(
                          'Dzikir Settings',
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Color(0xffE8F0EF), fontSize: 18),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: FutureBuilder<List<Settings>>(
                            future: this.handler.retrieveSettings(),
                            builder: (context,
                                AsyncSnapshot<List<dynamic>> snapshot) {
                              if (snapshot.hasData) {
                                return SwitchListTile(
                                  title: const Text(
                                    'Show dzikir reference',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xffE8F0EF),
                                    ),
                                  ),
                                  value: globalCounter.dzikirReference,
                                  activeColor: Colors.white,
                                  inactiveThumbColor: Colors.grey[400],
                                  onChanged: (bool value) {
                                    _referenceOnchange(value);
                                  },
                                );
                              } else if (snapshot.hasError) {
                                return Text("${snapshot.error}");
                              }
                              return CircularProgressIndicator();
                            },
                          ),
                        ),
                        Spacer(),
                      ]),
                    ),
                  )
                ]),
              ),
              Spacer(),
              Container(
                height: 180,
                margin: const EdgeInsets.fromLTRB(35, 0, 35, 55),
                padding: const EdgeInsets.fromLTRB(35, 25, 35, 25),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: Offset(2, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(children: [
                  Spacer(),
                  Container(
                    width: 200,
                    child: Text(
                      'Dukung kami dengan memberikan penilaian di appstore',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xff24573F), fontSize: 12),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 25, 0, 25),
                    width: 147,
                    height: 34,
                    child: ElevatedButton(
                      onPressed: () {
                        _launchInBrowser(_url);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff93BC9C),
                      ),
                      child: Text(
                        'Review',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                  Text(
                    'Version $appVersion',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xffAF9C4D), fontSize: 12),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
