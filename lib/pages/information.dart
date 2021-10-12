import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
// import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

class AppInformation extends StatefulWidget {
  AppInformation({Key? key}) : super(key: key);
  @override
  _AppInformation createState() => _AppInformation();
}

class _AppInformation extends State<AppInformation> {
  // This widget is the root of your application.

  String appVersion = '0.0.0';

  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      setState(() {
        appVersion = packageInfo.version;
      });
    });
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

  Widget build(BuildContext context) {
    const _url =
        'https://play.google.com/store/apps/details?id=com.farsi.dzikirapp';
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Column(
            children: [
              Flexible(
                child: Center(
                  child: Container(
                    height: 300,
                    margin: const EdgeInsets.fromLTRB(35, 0, 35, 55),
                    padding: const EdgeInsets.all(35),
                    alignment: Alignment.center,
                    child: Column(children: [
                      Text(
                        'Dzikir Application',
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(color: Color(0xff24573F), fontSize: 18),
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
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: Offset(2, 2), // changes position of shadow
                        ),
                      ],
                    ),
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
