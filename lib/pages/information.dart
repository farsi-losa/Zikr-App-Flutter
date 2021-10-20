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
              Flexible(
                child: Center(
                  child: Container(
                    height: 330,
                    margin: const EdgeInsets.fromLTRB(35, 0, 35, 55),
                    padding: const EdgeInsets.all(35),
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
                      Text(
                        'Dzikir Settings',
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(color: Color(0xff24573F), fontSize: 18),
                      ),
                      Container(
                        child: FutureBuilder<List<Settings>>(
                          future: this.handler.retrieveSettings(),
                          builder:
                              (context, AsyncSnapshot<List<dynamic>> snapshot) {
                            if (snapshot.hasData) {
                              return SwitchListTile(
                                title: const Text(
                                  'Show dzikir reference',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff24573F),
                                  ),
                                ),
                                value: globalCounter.dzikirReference,
                                activeColor: Color(0xff24573F),
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
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                width: 1.0, color: Color(0xffE7EFEE)),
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: 200,
                        child: Text(
                          'Dukung kami dengan memberikan penilaian di appstore',
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Color(0xff24573F), fontSize: 12),
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
                        style:
                            TextStyle(color: Color(0xffAF9C4D), fontSize: 12),
                      ),
                    ]),
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
